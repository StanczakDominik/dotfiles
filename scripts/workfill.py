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
import pandas as pd
import holidays

holidays_pl = holidays.Polish()

from dateutil.relativedelta import relativedelta

key = os.environ["TOGGL_KEY"]
auth = (key, "api_token")
workspace = os.environ["TOGGL_WORKSPACE"]
email = os.environ["TOGGL_EMAIL"]
work_tag = os.environ["TOGGL_WORK_TAG"]

today = datetime.date.today()

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

    fill_time = {}
    for yearmonth in pd.date_range('2019-12-01', datetime.date.today() + datetime.timedelta(days=32), freq='MS').strftime("%Y %m").tolist():
        year, month = yearmonth.split()
        month = int(month)
        year = int(year)
        value = get_total_from((year), (month))
        if value == 0:
            continue
        fill_time[yearmonth] = value 

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

def day_is_holiday(day):
    return (day.date() in holidays_pl) or (day.dayofweek >= 5)

def busday_count(start_date, end_date):
    busdays = 0
    for day in pd.date_range(start_date, end_date, freq='D')[:-1]:
        if not day_is_holiday(day):
            busdays += 1
    return busdays

def get_current_month_progress(df=None):
    if df is None:
        df = get_df()
    current = df.iloc[-1]
    remaining_undertime = df.iloc[-2].cumulative_overtime
    time_done_this_month_accounting_for_undertime = remaining_undertime + current.done
    start_month = today.replace(day=1)
    first_day_next_month = start_month + relativedelta(months=1)
    today_start_work = datetime.datetime.now().replace(hour=7,minute=0,second=0, microsecond=0)
    factor_today = min([
        (datetime.datetime.now() - today_start_work) / datetime.timedelta(hours=8),
        1]
                       )
    factor_today *= today.weekday() < 5
    work_days_since_start_month = busday_count(start_month, today)
    work_days_this_month = busday_count(start_month, first_day_next_month)
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
        return busday_count(today, first_day_next_month)
    else:
        return (first_day_next_month - today).days

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
