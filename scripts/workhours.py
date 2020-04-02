#!/usr/bin/env python
# coding: utf-8
import requests
import os
import datetime
import time

key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]

params = {
    "user_agent": email,
    "workspace_id": int(workspace),
    "tag_ids": work_tag,
    "since": datetime.date.today().isoformat(),
}

current_task = requests.get(
    "https://www.toggl.com/api/v8/time_entries/current", auth=auth
).json()["data"]
if current_task is not None and "tags" in current_task and "IFPILM" in current_task["tags"]:
    current_task_time = current_task["duration"] + time.time()
else:
    current_task_time = 0

url = "https://toggl.com/reports/api/v2/summary"
r = requests.get(url, auth=auth, params=params)
seconds = r.json()["total_grand"]
if seconds is not None:
    seconds /= 1000
else:
    seconds = 0
time_today_hours = datetime.timedelta(
    seconds=(seconds+ current_task_time)
)

date_this_month = datetime.date.today().replace(day=1)
params = {
    "user_agent": email,
    "workspace_id": int(workspace),
    "tag_ids": "7126563",
    "since": date_this_month,
}
r2 = requests.get(url, auth=auth, params=params)
seconds = r2.json()["total_grand"]
if seconds is not None:
    seconds /= 1000
else:
    seconds = 0
time_this_month = datetime.timedelta(
    seconds=(seconds + current_task_time)
)
time_required_today = (
    datetime.timedelta(hours=4)
    if datetime.date.today().weekday() == 4
    else datetime.timedelta(hours=8)
)
time_per_month = {  # accurate as of 2020
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
}
time_required_month = datetime.timedelta(
    hours=time_per_month[datetime.date.today().month] / 2
)


def td_as_h(td):
    s = td.total_seconds()
    hours = s // 3600
    s = s - (hours * 3600)
    minutes = s // 60
    seconds = s - (minutes * 60)
    return f"{int(hours):02d}:{int(minutes):02d}"

from dateutil.relativedelta import relativedelta
from datetime import datetime, date, timedelta
from calendar import weekday, monthrange, FRIDAY, WEDNESDAY, THURSDAY

print(f"Time today: {td_as_h(time_today_hours)} / {td_as_h(time_required_today)}")
if time_today_hours > time_required_today:
    print("Go home!")
else:
    n25 = (-time_today_hours + time_required_today)/timedelta(minutes=30)
    n52 = (-time_today_hours + time_required_today)/timedelta(minutes=69)
    print(f"{td_as_h(-time_today_hours + time_required_today)} remaining today - "
          f"{n25:.0f}x25 or {n52:.0f}x52 pomodoros.")
print(f"Time this month: {td_as_h(time_this_month)} / {td_as_h(time_required_month)}")



if time_this_month > time_required_month:
    print("Go home for the rest of the month, actually!")
else:
    n25 = (-time_this_month + time_required_month)/timedelta(minutes=30)
    n52 = (-time_this_month + time_required_month)/timedelta(minutes=69)
    print(f"{td_as_h(-time_this_month + time_required_month)} remaining this month - "
          f"{n25:.0f}x25 or {n52:.0f}x52 pomodoros.")

def num_days_between( start, end, week_day):
    num_weeks, remainder = divmod( (end-start).days, 7)
    if ( week_day - start.weekday() ) % 7 <= remainder:
       return num_weeks + 1
    else:
       return num_weeks

rozpiska = {FRIDAY: 4, WEDNESDAY: 8, THURSDAY: 8}
today = date.today()
first_day = today.replace(day=1) + relativedelta(months=1)
hours_remaining_available = sum([num_days_between(date.today(), first_day, day) * hours for day, hours in rozpiska.items()])

overtime = -time_this_month + time_required_month - timedelta(hours=hours_remaining_available)
if overtime > timedelta(seconds=0):
    print(f"Must fit in {td_as_h(overtime)} overtime sometime.")

