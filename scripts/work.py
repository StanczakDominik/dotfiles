#!/usr/bin/env python
# coding: utf-8
from calendar import weekday, monthrange, FRIDAY, WEDNESDAY, THURSDAY
from datetime import datetime, date, timedelta
from dateutil.relativedelta import relativedelta
from math import ceil
import calendar
import dateparser
import dateutil
import humanize
import math
import numpy as np
import os
import pandas
import pathlib
import requests
import time
key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]
today = date.today()


chill_projects = "141502477,141502549,141502946,147217653,148352666,148534427,148766728,150021963,150036826,150070561,150743908,151223027,152829725,154858133,154858881,155817483,156139235,157403954,157517194,158175677,19330977,19330987,23088688,30524866,31882430,35439582,37275803,37999828,51052890,68905520,71944118,76372541,76533336,160367027,161791765"
start_date = "2019-12-01"
end_date = "2020-02-29"

date_query = None # TODO argparse
if date_query is None:
    current_date = date.today()
else:
    current_date = dateparser.parse(date_query)

# TODO use current task 
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]
def calculate_original_proportion():
    url = f"https://toggl.com/app/reports/summary/{workspace}/from/{start_date}/projects/{projects}/tags/{work_tag}/to/{end_date}"
    # print(url)

    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "tag_ids": work_tag,
        "since": start_date,
        "until": end_date,
    }

    url = "https://toggl.com/reports/api/v2/summary"
    r = requests.get(url, auth=auth, params=params)
    all_time = r.json()['total_grand']
    params['project_ids'] = chill_projects
    r = requests.get(url, auth=auth, params=params)
    chill_time = r.json()['total_grand']

    focus_time = all_time - chill_time
    original_proportion = focus_time / all_time
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
break_length = timedelta(milliseconds=delta_proportion * all_time)
if delta_proportion > 0:
    print(f"Could take {humanize.naturaldelta(break_length)} ({break_length}) of a break if you'd like.")
elif delta_proportion < 0:
    print(f"Need {humanize.naturaldelta(break_length)} of focused work, still.")


for project in sorted(r_all.json()['data'], key=lambda item: item['time'], reverse=True):
    title = project['title']
    focused = "-" if (str(project['id']) in chill_projects) else "+"
    items = ", ".join(item['title']['time_entry'] for item in sorted(project['items'], key=lambda item: item['time'], reverse=True))
    print(f"{title['client']} - {title['project']} ({focused}, {project['id']}): {humanize.naturaldelta(timedelta(milliseconds=project['time']))} -  {items}")



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

def express_remainder(time_this_period, time_required, period_name, display_end_time = False):
    print(f"Time {period_name}: {td_as_h(time_this_period)} / {td_as_h(time_required)}", end = "\t")
    if display_end_time:
        print(f"Estimated time of finish: {datetime.now() + time_required - time_this_period:%X}")
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

time_required_today = (
    timedelta(hours=8)
    if date.today().isoweekday() <= 5
    else timedelta(hours=0)
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
    hours=time_per_month[date.today().year][date.today().month]
)

def time_in_projects_or_tags(
    since = date.today(),
    until = None,
    user_agent = email,
    workspace_id = int(workspace),
    tag_ids = 8229720,
    current_task_time = 0,
    project_ids = "157825064",
):
    url = "https://toggl.com/reports/api/v2/details"
    params = {
        "user_agent": email,
        "workspace_id": workspace_id,
        "tag_ids": tag_ids,
        "since": since,
        "until": until
    }
    r1 = requests.get(url, auth=auth, params=params)
    params = {
        "user_agent": email,
        "workspace_id": workspace_id,
        "project_ids": project_ids,
        "since": since,
        "until": until
    }
    r2 = requests.get(url, auth=auth, params=params)
    items = list({item['id']: item for item in r2.json()['data'] + r1.json()['data']}.values())
    return timedelta(milliseconds=sum(item['dur'] for item in items)).total_seconds() / 3600


monday = today - timedelta(days=today.weekday())

time_this_week = grab_seconds(since = monday, current_task_time = current_task_time)
required_weekly_time = timedelta(hours = 40)
next_monday = today - timedelta(days=today.weekday(), weeks = -1) - timedelta(days=2)


express_remainder(time_today_hours, time_required_today, "today", display_end_time=True)
spread(express_remainder(time_this_week, required_weekly_time, "this week"), next_monday)
masters_time = time_in_projects_or_tags()
print(f"Master's thesis time today: {masters_time:.2f}h, {masters_time / 3 :.0%} of 3h goal.")


offset = None
def get_total_from(year, month):
    last_day = calendar.monthrange(year, month)[1]
    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "tag_ids": work_tag,
        "since": date(year, month, 1),
        "until": date(year, month, last_day),
    }

    url = "https://toggl.com/reports/api/v2/summary"
    r = requests.get(url, auth=auth, params=params)
    total = r.json()['total_grand']
    if total is None:
        fill = 0
    else:
        fill = r.json()['total_grand'] / 1000 / 3600
    return fill

def get_df():
    df = pandas.read_csv(pathlib.Path(__file__).parent / "godziny_pracy.csv", index_col=0)

    fill_time = {-1: get_total_from(2019, 12)}
    for month in range(1, date.today().month+1):
        fill_time[month-1] = get_total_from(2020, month)

    df['done'] = pandas.Series(fill_time)
    df['req_cumsum'] = df['halftime'].cumsum()
    df['done_cumsum'] = df['done'].cumsum()
    df['cumulative_overtime'] = df.done_cumsum - df.req_cumsum
    return df.dropna()

def get_hours(df = None):
    if df is None:
        df = get_df()
    current = df.iloc[-1]
    return -current.cumulative_overtime

def get_current_month_progress(df=None):
    if df is None:
        df = get_df()
    current = df.iloc[-1]
    time_done_this_month_accounting_for_undertime = df.iloc[-2].cumulative_overtime + current.done
    start_month = today.replace(day=1)
    first_day_next_month = start_month + relativedelta(months=1)
    today_start_work = datetime.now().replace(hour=7,minute=0,second=0, microsecond=0)
    factor_today = (datetime.now() - today_start_work) / timedelta(hours=8)
    work_days_since_start_month = np.busday_count(start_month, today)
    work_days_this_month = np.busday_count(start_month, first_day_next_month)
    workday_proportion = (work_days_since_start_month + factor_today) / work_days_this_month 
    expected_time_atm = current.halftime * workday_proportion

    proportion = time_done_this_month_accounting_for_undertime / expected_time_atm - 1
    if proportion >= 0:
        desc_str = "ahead"
    else:
        desc_str = "behind"

    print(f"{time_done_this_month_accounting_for_undertime:.1f} hours done vs {expected_time_atm:.0f} expected by now. "
          f"{proportion:.0%} {desc_str}.")



def get_days_remaining_in_month(workdays = True, remaining = True):
    first_day_next_month = today.replace(day=1) + remaining * relativedelta(months=1)
    if workdays:
        return np.busday_count(today, first_day_next_month)
    else:
        return (first_day_next_month - today).days

def display_hour(hours):
    delta = timedelta(hours=hours)
    return delta

if __name__ == "__main__":
    df = get_df()
    hours = get_hours(df)
    workdays_remaining_in_month = get_days_remaining_in_month()
    days_remaining_in_month = get_days_remaining_in_month(False)
    days = {
        "days with today": days_remaining_in_month,
        "days without today": days_remaining_in_month - 1,
        "workdays with today": workdays_remaining_in_month,
        "workdays without today": workdays_remaining_in_month - 1,
        }

    with pandas.option_context('display.max_rows', None, 'display.max_columns', None):  # more options can be specified also
        print(df.round(1).to_string())

    print(f"Hours remaining this month: {hours:.1f}")
    if offset is not None:
        hours -= offset
        print(f"Hours without offset: {hours:.1f}")
    get_current_month_progress(df)
    for label, days_remaining in days.items():
        if days_remaining > 0:
            hours_per_day = hours / days_remaining
            pomos_per_day = math.ceil(hours_per_day * (60 / (25 + 5)))
            pomos_per_day2 = math.ceil(hours_per_day * (60 / (52 + 17)))
            print(f"{label}: {days_remaining}, hours per day: {display_hour(hours_per_day)}, pomodoros per day: {pomos_per_day:.0f} / {pomos_per_day2:.0f}")
