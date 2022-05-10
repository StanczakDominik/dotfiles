# If not running interactively, don't do anything
# TODO is this what fucks my env vars up?
[[ $- != *i* ]] && return

source $HOME/Code/dotfiles/bash/colors.bash

export EDITOR=nvim

source ~/.keysrc
export XDG_CURRENT_DESKTOP="KDE"
source /usr/share/git/completion/git-completion.bash

export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files'

function yt()
{
    streamlink $1 best &> /dev/null &
}

export PYTHONBREAKPOINT="pudb.set_trace"

source ~/.bash_completion
source ~/.bash_aliases

export JULIA_NUM_THREADS=4

eval $(thefuck --alias)
export SCIKIT_LEARN_DATA="$HOME/.sklearndata"

# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
# fi

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
set -o vi

export NLTK_DATA="$HOME/.nltk_data"
export REVIEW_BASE=master

source ~/.bashrc_local

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$MINICONDA_DIR/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$MINICONDA_DIR/etc/profile.d/conda.sh" ]; then
        . "$MINICONDA_DIR/etc/profile.d/conda.sh"
    else
        export PATH="$MINICONDA_DIR/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# https://wiki.archlinux.org/index.php/Bash#Mimic_Zsh_run-help_ability
run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
bind -m vi-insert -x '"\eh": run-help'
bind -m emacs -x     '"\eh": run-help'

