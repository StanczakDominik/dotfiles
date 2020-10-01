#!/usr/bin/python
from beeminder import create_goal
slugs = [
    # "todoist-backlog",
    # "todoist-unprioritized",
    # "todoist-breakdown",
    # "todoist-inbox",
    "papers-backlog",
    "youtube-backlog",
    "joplin-notes",
    "papers-notes",
    "screenshots-parse",
    # "jrnl",
    "toggl-tag",
    "github-inbox",
]
goals = [create_goal(slug=slug) for slug in slugs]
for goal in goals:
    goal.update()
