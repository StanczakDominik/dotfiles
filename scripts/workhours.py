#!/usr/bin/env python
# coding: utf-8
import requests
import os
import datetime
key = os.environ['TOGGL_KEY']
auth = (key, 'api_token')
workspace = os.environ['TOGGL_WORKSPACE']
email = os.environ['TOGGL_EMAIL']
params = {"user_agent": email,
          "workspace_id": int(workspace),
          "tag_ids": "7126563",
          "since": datetime.date.today().isoformat()}
url = "https://toggl.com/reports/api/v2/summary"
r = requests.get(url, auth=auth, params=params)
time_today_hours = r.json()['total_grand']/1000/3600
date_this_month = datetime.date.today().replace(day=1)
params = {"user_agent": email,
          "workspace_id": int(workspace),
          "tag_ids": "7126563",
          "since": date_this_month}
r2 = requests.get(url, auth=auth, params=params)
time_this_month = r2.json()['total_grand']/1000/3600
time_required_today = 4 if datetime.date.today().weekday() == 4 else 8

print(f"Time today: {time_today_hours:.2f} h / {time_required_today:.2f} h")
if time_today_hours > time_required_today:
    print("Go home!")
print(f"Time this month: {time_this_month:.2f} h / {80:.2f} h")
