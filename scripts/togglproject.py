#!/usr/bin/env python
# coding: utf-8
import pathlib
import toggl.api

f = pathlib.Path(".togglproject")
if f.is_file():
    with open(f) as F:
        project_name = [line.strip() for line in F.readlines()]
    print(project_name)

    project = toggl.api.models.Project.objects.get(name=project_name[0])

    c = toggl.api.TimeEntry.objects.current()

    needs_changing = False
    try:
        c.project
    except AttributeError:
        needs_changing = True
    else:
        if c.project.name in project_name:
            needs_changing = False
        else:
            needs_changing = True
    
    if needs_changing:
        print("Project name mismatch!")
        toggl.api.TimeEntry.start_and_save(project=project)
