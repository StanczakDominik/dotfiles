#!/usr/bin/env python
# coding: utf-8
import requests
import os
import datetime
import time
key = os.environ['TOGGL_KEY']
auth = (key, 'api_token')
workspace = os.environ['TOGGL_WORKSPACE']
email = os.environ['TOGGL_EMAIL']
params = {"user_agent": email,
          "workspace_id": int(workspace),
          "tag_ids": "7126563",
          "since": datetime.date.today().isoformat()}

current_task = requests.get('https://www.toggl.com/api/v8/time_entries/current', auth=auth).json()['data']
current_task_time = current_task['duration'] + time.time() if "IFPILM" in current_task['tags'] else 0

url = "https://toggl.com/reports/api/v2/summary"
r = requests.get(url, auth=auth, params=params)
time_today_hours = (r.json()['total_grand']/1000 + current_task_time)/3600

date_this_month = datetime.date.today().replace(day=1)
params = {"user_agent": email,
          "workspace_id": int(workspace),
          "tag_ids": "7126563",
          "since": date_this_month}
r2 = requests.get(url, auth=auth, params=params)
time_this_month = (r2.json()['total_grand']/1000 + current_task_time)/3600
time_required_today = 4 if datetime.date.today().weekday() == 4 else 8
time_required_month = 80  # TODO scrape this

print(f"Time today: {time_today_hours:.2f} h / {time_required_today:.0f} h")
if time_today_hours > time_required_today:
    print("Go home!")
else: 
    print(f"{-time_today_hours + time_required_today :.2f} h remaining.")
print(f"Time this month: {time_this_month:.2f} h / {time_required_month:.0f} h")

if time_this_month > time_required_month:
    print("Go home for the rest of the month, actually!")
else: 
    print(f"{-time_this_month + time_required_month :.2f} h remaining this month.")
