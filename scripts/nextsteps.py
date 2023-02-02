#!/usr/bin/env python
# coding: utf-8

import todoist_shared

from todoist_shared import api
api.sync()

import datetime
import dateutil

today =datetime.date.today()

import calendar
today = datetime.date.today()
friday = today + datetime.timedelta( (calendar.FRIDAY-today.weekday()) % 7 )

is_due_friday = lambda item: item['due'] is not None and dateutil.parser.parse(item['due']['date']).date() == friday
is_due_before_friday = lambda item: item['due'] is not None and dateutil.parser.parse(item['due']['date']).date() < friday
items_due_friday = api.items.all(is_due_friday)

# for item in items_due_friday:
#     print(item['content'])

def get_parent(task):
    if task['parent_id'] is None:
        return None
    return api.items.all(lambda item: item['id'] == task['parent_id'])[0]

# get_parent(item)

# get_parent(get_parent(item))

def get_final_parent(task):
    item = task
    while item['parent_id'] is not None:
        item = get_parent(item)
    return item
# get_final_parent(item)

def get_all_parents(task):
    item = task
    while item['parent_id'] is not None:
        item = get_parent(item)
        yield item
# list(get_all_parents(item))

def get_all_children(task, completed_only = False):
    for child in sorted(api.items.all(lambda child: get_parent(child) == task), key = lambda item: item['child_order']):
        if completed_only:
            if child.checked:
                continue
        yield child
# list(get_all_children(item))



need_next_steps = []
need_next_steps_before_friday = []
for item in items_due_friday:
    indent = 0
    for parent in get_all_parents(item):
        current_indent = indent * 4 * " "
        print(current_indent, parent['content'])
        indent += 1
    current_indent = indent * 4 * " "
    indent += 1
    print(current_indent, "*", item['content'])
    current_indent = indent * 4 * " "

    has_next_step = False
    has_next_step_due_by_Friday = False
    for child in get_all_children(item):
        if child['checked']:
            checkmark = "X"
        else:
            checkmark = " "
            has_next_step = True
            if is_due_before_friday(child):
                has_next_step_due_by_Friday = True
        print(current_indent, checkmark, child['content'])
    if not has_next_step:
        need_next_steps.append(item)
    if not (has_next_step or has_next_step_due_by_Friday):
        need_next_steps_before_friday.append(item)

# [item['content'] for item in need_next_steps]

for item in need_next_steps:
    try:
        new_task = input(f"What's the next step for {item['content']}?")
    except KeyboardInterrupt:
        continue
    else:
        api.add_item(new_task, parent_id = item['id'], date_string = "today")
for item in need_next_steps:
    print(f"{item['content']} needs rescheduling of children!")

api.commit()
