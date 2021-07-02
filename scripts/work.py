#!/usr/bin/env python
# coding: utf-8
import os
import requests
import datetime
import dateparser
import humanize
import math
from functools import cached_property
import time
import json
from rich import print
import yaml
import pathlib

key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]
path = pathlib.Path(__file__).parent / "goals.yaml"
with open(path) as f:
    goals = yaml.load(f, Loader=yaml.FullLoader)



def td_as_h(td: datetime.timedelta) -> str:
    s = td.total_seconds()
    hours = s // 3600
    s = s - (hours * 3600)
    minutes = s // 60
    seconds = s - (minutes * 60)
    return f"{int(hours):02d}:{int(minutes):02d}"


chill_projects = "162951165,141502477,141502549,141502946,147217653,148352666,148534427,148766728,150021963,150036826,150070561,150743908,151223027,152829725,154858133,154858881,155817483,156139235,157403954,157517194,158175677,19330977,19330987,23088688,30524866,31882430,35439582,37275803,37999828,51052890,68905520,71944118,76372541,76533336,160367027,161791765"
current_date = datetime.date.today()


def get_original_proportion(
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

    url = "https://toggl.com/reports/api/v2/summary"
    r = requests.get(url, auth=auth, params=params)
    all_time = r.json()["total_grand"]
    params["project_ids"] = chill_projects
    r = requests.get(url, auth=auth, params=params)
    chill_time = r.json()["total_grand"]

    focus_time = all_time - chill_time
    original_proportion = focus_time / all_time
    return original_proportion


# original_proportion = 4 * 52 / (4 * 52 + 3 * 17 + 60)
original_proportion = 0.70
daily_worktime = 8 * 3600


class WorkTimer:
    @cached_property
    def r_all_json(self):
        params = {
            "user_agent": email,
            "workspace_id": int(workspace),
            "tag_ids": work_tag,
            "since": current_date.isoformat(),
        }

        url = "https://toggl.com/reports/api/v2/summary"
        r_all = requests.get(url, auth=auth, params=params).json()
        return r_all

    @cached_property
    def r_detailed_json(self):
        params = {
            "user_agent": email,
            "workspace_id": int(workspace),
            "since": current_date.isoformat(),
        }

        url = "https://toggl.com/reports/api/v2/details"
        r_all = requests.get(url, auth=auth, params=params).json()
        # r_all['data'].append(self.r_current_json['data'])
        return r_all

    @cached_property
    def all_time(self):
        all_time = self.r_all_json["total_grand"]
        if all_time is None:
            all_time = 0
        return all_time + self.current_time

    @cached_property
    def chill_time(self):
        return sum(
            project["time"]
            for project in self.data
            if str(project["id"]) in chill_projects
        ) + self.current_time * self.current_task_is_chill

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
            "https://www.toggl.com/api/v8/time_entries/current", auth=auth
        ).json()
        return current_json

    @cached_property
    def current_time(self):
        current_task = self.r_current_json['data']
        if current_task is not None and "tags" in current_task and "IFPILM" in current_task["tags"]:
            current_task_time = current_task["duration"] + time.time()
        else:
            current_task_time = 0
        return current_task_time * 1000

    @cached_property
    def current_task_is_chill(self):
        current_task = self.r_current_json['data']
        if current_task is None or 'pid' not in current_task:
            return True
        return str(current_task['pid']) in chill_projects

    def describe_proportion(self):
        describer = "more" if self.delta_proportion > 0 else "less"
        print(
            f"{self.focus_proportion:.0%}: {abs(self.delta_proportion):.0%} {describer} focused wrt planned ratio {100*original_proportion:.0f}%"
        )
        current_focused_time = (self.time_done * self.focus_proportion).total_seconds()
        focus_goal = original_proportion * daily_worktime
        delta_time = current_focused_time - focus_goal
        if current_focused_time > focus_goal:
            print(f"Today's focus goal achieved. Take a break if you'd like.")
        else:
            focused_to_go = datetime.timedelta(seconds=focus_goal - current_focused_time)
            remaining_break = datetime.timedelta(seconds = daily_worktime) - focused_to_go - self.time_done
            print(f"Still need {td_as_h(focused_to_go)} focused time to go. Then, you may take a break of {td_as_h(abs(remaining_break))}.")

    @property
    def data(self):
        return self.r_all_json["data"]

    def describe_projects(self):
        if not self.data:
            return
        max_client_name = max(
            len(project["title"]["client"])
            for project in self.data
            if project["title"]["client"] is not None
        )
        max_project_name = max(
            len(project["title"]["project"])
            for project in self.data
            if project["title"]["project"] is not None
        )
        for project in sorted(self.data, key=lambda item: item["time"], reverse=True):
            title = project["title"]
            client = title["client"] if title["client"] is not None else ""
            projectname = title["project"] if title["project"] is not None else ""
            focused = "-" if (str(project["id"]) in chill_projects) else "+"
            items = ", ".join(
                item["title"]["time_entry"]
                for item in sorted(
                    project["items"], key=lambda item: item["time"], reverse=True
                )
            )
            print(
                f"{focused} {client: <{max_client_name}} - {projectname} : {td_as_h(datetime.timedelta(milliseconds=project['time']))} -  {items}"
            )

    @cached_property
    def time_done(self):
        return datetime.timedelta(milliseconds=self.all_time)

    time_required=datetime.timedelta(hours=8)
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
        description = task['description'] if 'description' in task else ''
        print(f"{focused} {description} : {td_as_h(datetime.timedelta(milliseconds=self.current_time))}")


    def describe_briefly(self, prefix = None):
        prefix = "" if prefix is None else prefix
        task = self.r_current_json['data']
        if task is not None:
            description = f", now: {task['description']} " if 'description' in task else ''
            description += td_as_h(datetime.timedelta(milliseconds=self.current_time))
        else:
            description = ''
        time_status = f"{td_as_h(self.time_done)} / {td_as_h(self.time_required)}, +{td_as_h(self.time_remaining)}"
        proportion_status = f"focus: {self.focus_proportion:.0%} ({self.delta_proportion:+.0%})"
        print(f"{prefix}{time_status}, {proportion_status}{description}")

    def describe_goals(self):
        def item_in_goal(item, goal):
            item_in_project = item['project'] in goal['projects']
            tags_intersect = bool(set(item['tags']).intersection(goal['tags'] ))
            return item_in_project or tags_intersect
        filtered = {name: list(filter(lambda i: item_in_goal(i, g), self.r_detailed_json['data'])) for name, g in goals.items()}
        total_durations = {key: sum(item['dur'] for item in goal_items)/3600_000 for key, goal_items in filtered.items()}
        fractions = {key: total_durations[key] / goal["daily_time_hours"] for key, goal in goals.items()}
        for key, goal in goals.items():
            fraction = fractions[key]
            duration = total_durations[key]
            planned_duration = goal['daily_time_hours']
            state = "completed!" if fraction > 1 else ""
            print(f"{key}: {fraction:.0%} ({duration:.1f}h / {planned_duration:.1f}h) {state}")



if __name__ == "__main__":
    timer = WorkTimer()
    timer.describe_proportion()
    timer.describe_projects()
    timer.describe_current()
    timer.express_remainder(pomodoros=True)
    timer.describe_briefly()
    timer.describe_goals()
