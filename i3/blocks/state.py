#!/usr/bin/env python3
import json
from os import environ as ENV

STATES = { "ready" : "running", "running" : "blocked", "blocked" : "ready" }

state = STATES[ENV["_state"]]
block = { "full_text" : state, "_state" : state }

print(json.dumps(block))
