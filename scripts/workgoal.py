#!/usr/bin/env python
"""Prints current work status in a single line."""
from work import WorkTimer
import datetime
import holidays

def single_line():
    timer = WorkTimer()
    now = datetime.datetime.now().strftime("%X")
    timer.describe_briefly(f"{now}: ")

if __name__ == "__main__":
    holidays_pl = holidays.Polish()
    today = datetime.date.today()
    if (today in holidays_pl) or (today.weekday() >= 5):
        print("Enjoy your free day!")
    else:
        single_line()

