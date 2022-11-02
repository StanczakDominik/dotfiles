#!/bin/bash

# Only one key binding is required, the first keypress performs
# initialisation and hides the terminal again.
if  [ "_$(xdotool search --classname "Scratchpad" | head -1)"  = "_" ]; then
    alacritty --title Scratchpad &
    sleep 0.3
    # Set the instance to identify the scratchpad.
    xdotool getwindowfocus set_window --classname "Scratchpad"
    i3-msg "[instance=\"Scratchpad\"] resize set 900 px 0 px"
    i3-msg "[instance=\"Scratchpad\"] move absolute position 2112 24"
    # i3-msg "[instance=\"Scratchpad\"] move scratchpad"
else
    i3-msg "focus output ${cmon}"
    i3-msg "[instance=\"Scratchpad\"] scratchpad show"
fi
