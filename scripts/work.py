#!/usr/bin/env python
import textwrap
# coding: utf-8
import os
import requests
import datetime
import dateparser
import pandas
import humanize
import math
from functools import cached_property
import time
import json
from rich import print
import yaml
import pathlib
from copy import deepcopy

key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]

path = pathlib.Path(__file__).parent / "workhours.yaml"
with open(path) as f:
    workhours = yaml.load(f, Loader=yaml.FullLoader)

def workday_override(path="/tmp/WORKDAY"):
    return True


def td_as_h(td: datetime.timedelta) -> str:
    s = td.total_seconds()
    hours = s // 3600
    s = s - (hours * 3600)
    minutes = s // 60
    seconds = s - (minutes * 60)
    return f"{int(hours):02d}:{int(minutes):02d}"


current_date = datetime.date.today()


def get_original_proportion(
    work_tag,
    start_date="2019-12-01",
    end_date="2020-02-29",
    date_query=None,  # TODO argparse
):
    if date_query is None:
        current_date = datetime.date.today()
    else:
        current_date = dateparser.parse(date_query)
    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "tag_ids": work_tag,
        "since": start_date,
        "until": end_date,
    }

    url = "https://api.track.toggl.com/reports/api/v2/summary"
    r = requests.get(url, auth=auth, params=params)
    all_time = r.json()["total_grand"]
    params["project_ids"] = self.chill_projects
    r = requests.get(url, auth=auth, params=params)
    chill_time = r.json()["total_grand"]

    focus_time = all_time - chill_time
    original_proportion = focus_time / all_time
    return original_proportion


# original_proportion = 4 * 52 / (4 * 52 + 3 * 17 + 60)
original_proportion = 0.70

def r_all_json():
    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "since": current_date.isoformat(),
    }

    url = "https://api.track.toggl.com/reports/api/v2/details"
    r_all = requests.get(url, auth=auth, params=params).json()
    return r_all
global_json = r_all_json()

from dataclasses import dataclass, InitVar
@dataclass
class WorkTimer:
    name: str
    tag: str
    tag_id: int
    project: int
    client: str
    daily_time: InitVar[str]
    chill_projects: str = ""

    def __post_init__(self, daily_time):
        times = daily_time.split("/")
        time_for_today = int(times[current_date.weekday()])
        self.time_required = datetime.timedelta(hours=time_for_today)

    @cached_property
    def r_all_json(self):
        r_all = deepcopy(global_json)
        r_all.pop("total_billable")
        r_all.pop("total_currencies")
        def filterfunc(item):
            if item['client'] == self.client:
                return True
            if item['project'] == self.project:
                return True
            if self.tag in item['tags']:
                return True
            return False
        r_all['data'] = list(filter(filterfunc, r_all['data']))
        r_all['total_grand'] = sum(item['dur'] for item in r_all['data'])
        return r_all

    @cached_property
    def entry_dataframe(self):
        return pandas.DataFrame(self.r_all_json['data'])

    @cached_property
    def all_time(self):
        all_time = self.r_all_json["total_grand"]
        if all_time is None:
            all_time = 0
        return all_time + self.current_time_if_work

    @cached_property
    def chill_time(self):
        return self.entry_dataframe[self.entry_dataframe.pid.astype(str).isin(self.chill_projects.split(","))].dur.sum() + self.current_time_if_work * self.current_task_is_chill

    @cached_property
    def focus_time(self):
        return self.all_time - self.chill_time

    @cached_property
    def focus_proportion(self):
        if self.all_time == 0:
            return 0
        return self.focus_time / self.all_time

    @cached_property
    def delta_proportion(self):
        return self.focus_proportion - original_proportion

    @cached_property
    def r_current_json(self):
        current_json = requests.get(
            "https://api.track.toggl.com/api/v8/time_entries/current", auth=auth
        ).json()
        return current_json

    @cached_property
    def current_time_if_work(self):
        current_task = self.r_current_json['data']
        if "tags" in current_task and self.tag in current_task["tags"]:
            return self.current_time
        elif "pid" in current_task and self.project == current_task["pid"]:
            return self.current_time
        else:
            return 0
    
    @cached_property
    def current_time(self):
        current_task = self.r_current_json['data']
        if current_task is not None:
            current_task_time = current_task["duration"] + time.time()
        else:
            current_task_time = 0
        return current_task_time * 1000

    @cached_property
    def current_task_is_chill(self):
        current_task = self.r_current_json['data']
        if current_task is None or 'pid' not in current_task:
            return True
        return str(current_task['pid']) in self.chill_projects

    def describe_proportion(self):
        if not self.chill_projects:
            return
        describer = "more" if self.delta_proportion > 0 else "less"
        print(
            f"{self.focus_proportion:.0%}: {abs(self.delta_proportion):.0%} {describer} focused wrt planned ratio {100*original_proportion:.0f}%"
        )
        current_focused_time = (self.time_done * self.focus_proportion).total_seconds()
        if self.delta_proportion > 0:
            remaining_break = self.time_done * self.delta_proportion
            print(f"Take a break of {td_as_h(remaining_break)} if you'd like.")

    @property
    def data(self):
        return self.r_all_json["data"]

    def describe_projects(self):
        if not self.data:
            return
        max_client_name = self.entry_dataframe['client'].str.len().max()
        for project, project_group in self.entry_dataframe.groupby("project"):
            focused = "-" if (str(project_group["pid"].iloc[0]) in self.chill_projects) else "+"
            client = project_group["client"].iloc[0] if project_group["client"] is not None else ""
            items = ", ".join(set(project_group.sort_values("dur", ascending=False).description))
            print(
                f"{focused} {client: <{max_client_name}} - {project} :"
                f"{td_as_h(datetime.timedelta(milliseconds=int(project_group['dur'].sum())))}"
                f"-  {items}"
            )

    @cached_property
    def time_done(self):
        return datetime.timedelta(milliseconds=self.all_time)

    @cached_property
    def time_remaining(self):
        return self.time_required - self.time_done 

    def express_remainder(
        self,
        display_end_time=True,
        pomodoros=False,
    ):
        print(
            f"Time today: {td_as_h(self.time_done)} / {td_as_h(self.time_required)}",
            end="\t",
        )
        if self.time_done > self.time_required:
            print(f"Enough for today!")
        elif display_end_time:
            print(
                f"Estimated time of finish: {datetime.datetime.now() + self.time_required - self.time_done:%X}"
            )
        else:
            print("")
        if pomodoros:
            n25 = math.ceil(
                (-self.time_done + self.time_required) / datetime.timedelta(minutes=30)
            )
            n52 = math.ceil(
                (-self.time_done + self.time_required)
                / datetime.timedelta(minutes=52 + 17)
            )
            print(
                f"{td_as_h(self.time_remaining)} remaining today - "
                f"{n25:.0f}x25 or {n52:.0f}x52 pomodoros."
            )
            return n52

    def describe_current(self):
        focused = '-' if self.current_task_is_chill else '+'
        task = self.r_current_json['data']
        if self.current_time_if_work == 0:
            return
        description = task['description'] if (task and 'description' in task) else ''
        print(f"{focused} {description} : {td_as_h(datetime.timedelta(milliseconds=self.current_time))}")


    def describe_briefly(self, prefix = None, maxwidth = 35):
        prefix = "" if prefix is None else prefix
        task = self.r_current_json['data']
        if task is not None and 'description' in task:
            data = task['description']
            description = textwrap.shorten(data, width=maxwidth)
            description = f", now: {description} {td_as_h(datetime.timedelta(milliseconds = self.current_time))}"
        else:
            description = ''
        time_status = f"{td_as_h(self.time_done)} / {td_as_h(self.time_required)}"
        if self.time_remaining.total_seconds() > 0:
            est_end_time = f' ->| {(datetime.datetime.now() + self.time_remaining).strftime("%H:%M")}'
            time_status += est_end_time
        return f"{self.name}: {prefix}{time_status}{description}"

    @property
    def is_inactive_today(self):
        return self.time_remaining.total_seconds() <= 0

if __name__ == "__main__":
    for k, d in workhours.items():
        timer = WorkTimer(k, **d)
        if timer.is_inactive_today:
            continue
        print(timer.name)
        timer.describe_proportion()
        timer.describe_projects()
        timer.describe_current()
        timer.express_remainder(pomodoros=True)
