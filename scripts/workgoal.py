#!/usr/bin/env python
"""Prints current work status in a single line."""
from work import WorkTimer, workhours
import datetime
import holidays
import pathlib
import json
import os

def workday_override(path="/tmp/WORKDAY"):
    path = pathlib.Path(path)
    try:
        return float(path.read_text())
    except:
        return path.exists()



list_entries = list(workhours.items())
def single_line(index):
    if index > (len(list_entries) + 1):
        print("All done")
        return
    next_index = (index+1)
    k, d = list_entries[index % len(list_entries)]
    timer = WorkTimer(k, **d)
    if timer.is_inactive_today:
        return single_line(next_index)
    now = datetime.datetime.now().strftime("%X")
    print(timer.describe_briefly(f"{now}: "))
    # TODO json format, set color as percentage from red to white, or RGB for each goal

if __name__ == "__main__":
    single_line(os.environ.get("_state", 0))

