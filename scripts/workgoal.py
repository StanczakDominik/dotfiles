#!/usr/bin/env python
"""Prints current work status in a single line."""
from work import WorkTimer, workhours
import datetime
import holidays
import pathlib
import json
import os
from requests.exceptions import ConnectionError

list_entries = list(workhours.items())
def single_line(index):
    index = index % len(list_entries)
    k, d = list_entries[index % len(list_entries)]
    try:
        timer = WorkTimer(k, **d)
    except ConnectionError:
        print(json.dumps({"_state": index, "full_text": "No network."}))
        return
    next_index = (index+1)
    if timer.is_inactive_today:
        return single_line(next_index)
    now = datetime.datetime.now().strftime("%X")
    text = timer.describe_briefly(f"{now}: ")
    print(json.dumps({"_state": next_index if timer.is_inactive_today else index, "full_text": text}))

if __name__ == "__main__":
    single_line(int(os.environ.get("_state", 0)))

