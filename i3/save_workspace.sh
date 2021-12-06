#!/bin/bash
CURRENT_WORKSPACE=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
i3-save-tree > ~/Code/dotfiles/i3/workspaces/$CURRENT_WORKSPACE.json
