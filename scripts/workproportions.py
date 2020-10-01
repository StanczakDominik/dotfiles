#!/usr/bin/env python
# coding: utf-8
import os
import requests 
import datetime
import dateparser
import humanize
key = os.environ["TOGGL_KEY"]

chill_projects = "129852973,141502477,141502549,141502946,147217653,148352666,148534427,148766728,150021963,150036826,150070561,150743908,151223027,152829725,154858133,154858881,155817483,156139235,157403954,157517194,158175677,158222247,19330977,19330987,23088688,30524866,31882430,35439582,37275803,37999828,51052890,68905520,71944118,76372541,76533336,160367027,161791765"
start_date = "2019-12-01"
end_date = "2020-02-29"

date_query = None # TODO argparse
if date_query is None:
    current_date = datetime.date.today()
else:
    current_date = dateparser.parse(date_query)

# TODO use current task 
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]
# url = f"https://toggl.com/app/reports/summary/{workspace}/from/{start_date}/projects/{projects}/tags/{work_tag}/to/{end_date}"
# # print(url)

# params = {
#     "user_agent": email,
#     "workspace_id": int(workspace),
#     "tag_ids": work_tag,
#     "since": start_date,
#     "until": end_date,
# }

# url = "https://toggl.com/reports/api/v2/summary"
# r = requests.get(url, auth=auth, params=params)
# all_time = r.json()['total_grand']
# params['project_ids'] = chill_projects
# r = requests.get(url, auth=auth, params=params)
# chill_time = r.json()['total_grand']

# focus_time = all_time - chill_time
# original_proportion = focus_time / all_time
original_proportion = 52 / (52 + 17 + 60 / 4)

params = {
    "user_agent": email,
    "workspace_id": int(workspace),
    "tag_ids": work_tag,
    "since":  current_date.isoformat(),
}

url = "https://toggl.com/reports/api/v2/summary"
r_all = requests.get(url, auth=auth, params=params)
all_time = r_all.json()['total_grand']
params['project_ids'] = chill_projects
r = requests.get(url, auth=auth, params=params)
chill_time = r.json()['total_grand']
if chill_time is None:
    chill_time = 0

focus_time = all_time - chill_time
proportion = focus_time / all_time
dprop = proportion - original_proportion
describer = "more" if dprop > 0 else "less"
print(f"{proportion:.0%}: {abs(dprop):.0%} {describer} focused wrt planned ratio {100*original_proportion:.0f}%")

delta_proportion = proportion - original_proportion
if delta_proportion > 0:
    break_length = datetime.timedelta(milliseconds=delta_proportion * all_time)
    print(f"Could take {humanize.naturaldelta(break_length)} ({break_length}) of a break if you'd like.")

for project in sorted(r_all.json()['data'], key=lambda item: item['time'], reverse=True):
    title = project['title']
    focused = "-" if (str(project['id']) in chill_projects) else "+"
    items = ", ".join(item['title']['time_entry'] for item in sorted(project['items'], key=lambda item: item['time'], reverse=True))
    print(f"{title['client']} - {title['project']} ({focused}, {project['id']}): {humanize.naturaldelta(datetime.timedelta(milliseconds=project['time']))} -  {items}")
