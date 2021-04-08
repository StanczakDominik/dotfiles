#!/usr/bin/python
from beeminder import create_goal
import time
slugs = [
    # "todoist-backlog",
    # "todoist-unprioritized",
    # "todoist-breakdown",
    "todoist-inbox",
    "papers-backlog",
    "youtube-backlog",
    "joplin-notes",
    "papers-notes",
    "screenshots-parse",
    "jrnl",
    "toggl-tag",
    "github-inbox",
    "wallabag-backlog",
    "gratitude",
    "lichess",
    "lichess-puzzles",
    "lichess-puzzles-rating",
    "lichess-games",
    "lichess-blitz-rating",
    "youtube-backlog",
]
goals = [create_goal(slug=slug) for slug in slugs]
for goal in goals:
    try:
        goal.update()
    except Exception as e:
        print(e)
