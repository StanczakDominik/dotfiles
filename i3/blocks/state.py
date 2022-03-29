#!/usr/bin/env python3
import json
from os import environ as ENV

STATES = { "ready" : "running", "running" : "blocked", "blocked" : "ready" }

current_state = STATES[ENV["_state"]]
block = { "full_text" : current_state, "_state" : current_state }

print(json.dumps(block))
