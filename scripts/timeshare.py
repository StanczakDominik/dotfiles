#!/usr/bin/env python
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

url = f"https://www.toggl.com/api/v8/workspaces/{workspace}/projects"
projects = requests.get(url, auth=auth, params=dict(actual_hours=True)).json()
url = f"https://www.toggl.com/api/v8/workspaces/{workspace}/clients"
clients = requests.get(url, auth=auth).json()
client_names = {c['id']: c['name'] for c in clients}

params = {
    "user_agent": email,
}
projects_weekly = requests.get(f"https://toggl.com/reports/api/v2/weekly?workspace_id={workspace}", auth=auth, params=params).json()

import astropy.units as u

total_grand = (projects_weekly['total_grand'] * u.ms).to(u.h)

key = 'time'
keys = {'client': lambda x: True,
        'time': lambda project: -sum(x for x in project['totals'] if x is not None),
       }   
for project in sorted(projects_weekly['data'], key=keys[key]):
    project_id = project['pid']
    title = project['title']
    client = title['client']
    project_name = title['project']
    hex_color = title['hex_color']
    runtime_hours = (sum(x for x in project['totals'] if x is not None) * u.ms).to(u.h)
    percentage = 100 * runtime_hours / total_grand
    print(f"{client} - {project_name}: {runtime_hours:.2f}, {percentage:.0f}%")

print("\n\tUndone this week:")
done_ids = [project['pid'] for project in projects_weekly['data']]
undone_projects = [project for project in projects if project['id'] not in done_ids]
for p in sorted(undone_projects, key=lambda project: project['cid'] if 'cid' in project else 0):
    client = client_names[p['cid']] if 'cid' in p else None
    project_name = p['name']
    print(f"{client} - {project_name}")
