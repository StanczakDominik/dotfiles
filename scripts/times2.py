#!/usr/bin/env python
# coding: utf-8
import fileinput

times = fileinput.input()
import datetime

HH = 0
MM = 0
SS = 0
for time in times:
    try:
        mm, ss= time.strip().split(":")
        hh = 0
    except ValueError:
        hh, mm, ss = time.strip().split(":")
    HH += int(hh)
    MM += int(mm)
    SS += int(ss)

time_in_hours = HH + MM / 60 + SS / 3600
print(time_in_hours)
