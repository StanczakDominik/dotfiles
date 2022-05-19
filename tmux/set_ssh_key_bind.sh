#!/bin/bash
if [[ -n $SSH_TTY ]];then
    tmux display-message "Indeed, a ssh session"
    tmux bind-key -n C-a send-prefix
else
    tmux display-message "Not a ssh session"
fi
