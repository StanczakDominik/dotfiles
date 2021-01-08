#!/usr/bin/env python
# coding: utf-8
import os
import requests
import datetime
import dateparser
import humanize
import math
from functools import cached_property

key = os.environ["TOGGL_KEY"]
# TODO use current task
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]


def td_as_h(td: datetime.timedelta):
    s = td.total_seconds()
    hours = s // 3600
    s = s - (hours * 3600)
    minutes = s // 60
    seconds = s - (minutes * 60)
    return f"{int(hours):02d}:{int(minutes):02d}"


chill_projects = "141502477,141502549,141502946,147217653,148352666,148534427,148766728,150021963,150036826,150070561,150743908,151223027,152829725,154858133,154858881,155817483,156139235,157403954,157517194,158175677,19330977,19330987,23088688,30524866,31882430,35439582,37275803,37999828,51052890,68905520,71944118,76372541,76533336,160367027,161791765"
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
original_proportion = 2 / 3


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
        r_all = requests.get(url, auth=auth, params=params)
        return r_all.json()

    @cached_property
    def all_time(self):
        all_time = self.r_all_json["total_grand"]
        return all_time

    @cached_property
    def chill_time(self):
        return sum(
            project["time"]
            for project in self.data
            if str(project["id"]) in chill_projects
        )

    @cached_property
    def focus_time(self):
        return self.all_time - self.chill_time

    @cached_property
    def focus_proportion(self):
        return self.focus_time / self.all_time

    @cached_property
    def delta_proportion(self):
        return self.focus_proportion - original_proportion

    def describe_proportion(self, breaks=False):
        describer = "more" if self.delta_proportion > 0 else "less"
        print(
            f"{self.focus_proportion:.0%}: {abs(self.delta_proportion):.0%} {describer} focused wrt planned ratio {100*original_proportion:.0f}%"
        )
        if breaks:
            break_length = datetime.timedelta(
                milliseconds=self.delta_proportion * self.all_time
            )
            if self.delta_proportion > 0:
                print(f"Could take {td_as_h(break_length)}  of a break if you'd like.")
            elif self.delta_proportion < 0:
                print(f"Need {td_as_h(break_length)} of focused work, still.")

    @property
    def data(self):
        return self.r_all_json["data"]

    def describe_projects(self):
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
        time_this_period = datetime.timedelta(milliseconds=self.all_time)
        print(
            f"Time today: {td_as_h(self.time_done)} / {td_as_h(self.time_required)}",
            end="\t",
        )
        if self.time_done > self.time_required:
            print(f"Enough for {period_name}!")
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

    def describe_briefly(self, prefix = None):
        prefix = "" if prefix is None else prefix
        time_status = f"{td_as_h(self.time_done)} / {td_as_h(self.time_required)}, +{td_as_h(self.time_remaining)}"
        proportion_status = f"focus: {self.focus_proportion:.0%} ({self.delta_proportion:+.0%})"
        print(f"{prefix}{time_status}, {proportion_status}")


if __name__ == "__main__":
    timer = WorkTimer()
    timer.describe_proportion(breaks=True)
    timer.describe_projects()
    timer.express_remainder(pomodoros=True)
    timer.describe_briefly()
