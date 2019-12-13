#
# ~/.bashrc
#

# If not running interactively, don't do anything
# TODO is this what fucks my env vars up?
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


# COLORS
RESTORE='\[\033[0m\]'

RED='\[\033[00;31m\]'
GREEN='\[\033[00;32m\]'
YELLOW='\[\033[00;33m\]'
BLUE='\[\033[00;34m\]'
PURPLE='\[\033[00;35m\]'
CYAN='\[\033[00;36m\]'
LIGHTGRAY='\[\033[00;37m\]'

LRED='\[\033[01;31m\]'
LGREEN='\[\033[01;32m\]'
LYELLOW='\[\033[01;33m\]'
LBLUE='\[\033[01;34m\]'
LPURPLE='\[\033[01;35m\]'
LCYAN='\[\033[01;36m\]'
WHITE='\[\033[01;37m\]'
export BROWSER=firefox


source /usr/share/git/completion/git-prompt.sh
#PS1="${LYELLOW}\t ${CYAN}\u${RESTORE}@${LRED}\h${RESTORE}:${LGREEN} \w${RESTORE} \\$ \[$(tput sgr0)\]"
PS1="${LYELLOW}\t ${CYAN}\u${RESTORE}:${LGREEN} \w${RESTORE} \\$ \[$(tput sgr0)\]"

EDITOR=nvim

source ~/.keysrc
# export QT_QPA_PLATFORMTHEME="qt5ct"
export XDG_CURRENT_DESKTOP="KDE"
source /usr/share/git/completion/git-completion.bash

export PATH=/home/dominik/Code/scripts:$PATH:/home/dominik/.gem/ruby/2.6.0/bin
export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files'

function yt()
{
    streamlink $1 best &> /dev/null &
}

# HISTIGNORE="$HISTIGNORE:jrnl *"
# eval "`nikola tabcompletion`"
# export PYTHONBREAKPOINT=ipdb.set_trace
# export PYTHONBREAKPOINT="import pudb; pu.db"
export PYTHONBREAKPOINT="pudb.set_trace"


source ~/.bash_completion
source ~/.bash_aliases

export JULIA_NUM_THREADS=4

eval $(thefuck --alias)
export SCIKIT_LEARN_DATA=/home/dominik/.sklearndata

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
set -o vi

export NLTK_DATA="/home/dominik/.nltk_data"
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
