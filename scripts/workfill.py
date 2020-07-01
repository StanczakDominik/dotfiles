#!/usr/bin/env python

import numpy as np
import pathlib
import humanize
import pandas
import calendar
import os
import requests 
import datetime
import dateutil
import math
key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]


offset = None
def get_total_from(year, month):
    last_day = calendar.monthrange(year, month)[1]
    params = {
        "user_agent": email,
        "workspace_id": int(workspace),
        "tag_ids": work_tag,
        "since": datetime.date(year, month, 1),
        "until": datetime.date(year, month, last_day),
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
    for month in range(1, datetime.date.today().month+1):
        fill_time[month-1] = get_total_from(2020, month)

    df['done'] = pandas.Series(fill_time)
    df['req_cumsum'] = df['halftime'].cumsum()
    df['done_cumsum'] = df['done'].cumsum()
    df['cumulative_overtime'] = df.done_cumsum - df.req_cumsum
    return df.dropna()

def get_hours(df = None):
    if df is None:
        df = get_df()
    current = df.loc[datetime.date.today().month-1]
    return -current.cumulative_overtime

def get_days_remaining_in_month(workdays = True):
    today = datetime.date.today()
    from dateutil.relativedelta import relativedelta
    first_day = today.replace(day=1) + relativedelta(months=1)
    if workdays:
        return np.busday_count(today, first_day)
    else:
        return (first_day - today).days

def display_hour(hours):
    delta = datetime.timedelta(hours=hours)
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
        print(df.to_string())

    print(f"Hours remaining: {hours:.1f}")
    if offset is not None:
        hours -= offset
        print(f"Hours without offset: {hours:.1f}")
    for label, days_remaining in days.items():
        if days_remaining > 0:
            hours_per_day = hours / days_remaining
            pomos_per_day = math.ceil(hours_per_day * (60 / (25 + 5)))
            pomos_per_day2 = math.ceil(hours_per_day * (60 / (52 + 17)))
            print(f"{label}: {days_remaining}, hours per day: {display_hour(hours_per_day)}, pomodoros per day: {pomos_per_day:.0f} / {pomos_per_day2:.0f}")
