#!/usr/bin/env python
import requests
import os
import datetime
import time
from dateutil import relativedelta
import workfill
from math import ceil

key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]

def grab_current_time():
    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "tag_ids": work_tag,
        "since": date.today().isoformat(),
    }

    current_task = requests.get(
        "https://www.toggl.com/api/v8/time_entries/current", auth=auth
    ).json()["data"]
    if current_task is not None and "tags" in current_task and "IFPILM" in current_task["tags"]:
        current_task_time = current_task["duration"] + time.time()
    else:
        current_task_time = 0
    return current_task_time


def grab_seconds(since = None, until = None, user_agent = email, workspace_id = int(workspace), tag_ids = "7126563",
                 current_task_time = 0,
                ):
    url = "https://toggl.com/reports/api/v2/summary"
    params = {
        "user_agent": email,
        "workspace_id": workspace_id,
        "tag_ids": tag_ids,
        "since": since,
        "until": until
    }
    r2 = requests.get(url, auth=auth, params=params)

    seconds = r2.json()['total_grand'] 
    if seconds is not None:
        seconds /= 1000
    else:
        seconds = 0

    time_this_week = timedelta(
        seconds=(seconds + current_task_time)
    )
    return time_this_week


def td_as_h(td):
    s = td.total_seconds()
    hours = s // 3600
    s = s - (hours * 3600)
    minutes = s // 60
    seconds = s - (minutes * 60)
    return f"{int(hours):02d}:{int(minutes):02d}"

from dateutil import relativedelta
from datetime import datetime, date, timedelta
from calendar import weekday, monthrange, FRIDAY, WEDNESDAY, THURSDAY

def express_remainder(time_this_period, time_required, period_name):
    print(f"Time {period_name}: {td_as_h(time_this_period)} / {td_as_h(time_required)}", end = "\t")
    if time_this_period > time_required:
        print(f"Enough for {period_name}!")
        return 0
    else:
        n25 = ceil((-time_this_period + time_required)/timedelta(minutes=30))
        n52 = ceil((-time_this_period + time_required)/timedelta(minutes=69))
        print(f"{td_as_h(-time_this_period + time_required)} remaining {period_name} - "
              f"{n25:.0f}x25 or {n52:.0f}x52 pomodoros.")
        return n52

def spread(n52, end_period):
    remaining = end_period - today
    if remaining.days > 0:
        print(f"That's {round(n52 / remaining.days):.0f} 52-pomodoros every day over the next {remaining.days} days.")

current_task_time = grab_current_time()
time_today_hours = grab_seconds(since = date.today(), current_task_time = current_task_time)
time_this_month = grab_seconds(since = date.today().replace(day=1), current_task_time = current_task_time)

time_required_today = (
    timedelta(hours=4)
    # if date.today().weekday() <= 4
    # else timedelta(hours=0)
)

time_per_month = {2020:{
    1: 168,
    2: 160,
    3: 176,
    4: 168,
    5: 160,
    6: 168,
    7: 184,
    8: 160,
    9: 176,
    10: 176,
    11: 160,
    12: 168,
}}
time_required_month = timedelta(
    hours=time_per_month[date.today().year][date.today().month] / 2
)


today = date.today()
monday = today - timedelta(days=today.weekday())

time_this_week = grab_seconds(since = monday, current_task_time = current_task_time)
required_weekly_time = timedelta(hours = 20)
next_monday = today - timedelta(days=today.weekday(), weeks = -1)


end_of_month = today - timedelta(days=today.day) + relativedelta.relativedelta(months=1)
express_remainder(time_today_hours, time_required_today, "today")
spread(express_remainder(time_this_week, required_weekly_time, "this week"), next_monday)
spread(express_remainder(time_this_month, time_required_month, "this month"), end_of_month)
