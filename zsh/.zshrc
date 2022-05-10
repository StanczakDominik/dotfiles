# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
setopt appendhistory autocd nomatch notify
stty -ixon
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$ZDOTDIR/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
#
# autoload -Uz promptinit
# promptinit


# PROMPT='{yellow}\t {cyan}\u{RESTORE}:${LGREEN} \w${RESTORE} \\$ \[$(tput sgr0)\]'
PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
RPROMPT='[%F{yellow}%?%f]'
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# »'
else
  PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
fi
RPROMPT='[%F{yellow}%?%f]'

eval "$(starship init zsh)"


bindkey -M vicmd '^[h' run-help
bindkey -M viins '^[h' run-help

bindkey -M vicmd 'K' run-help


zstyle ':completion:*' rehash true



export PATH=/home/dstanczak/Code/scripts:/home/dstanczak/Code/dotfiles/scripts:$PATH:/home/dstanczak/.local/bin:/home/dstanczak/.gem/ruby/2.7.0/bin

setopt COMPLETE_ALIASES

# incremental history https://unix.stackexchange.com/questions/30168/how-to-enable-reverse-search-in-zsh
bindkey '^R' history-incremental-search-backward
export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim


function yt()
{
    streamlink $1 best &> /dev/null &
}

export PYTHONBREAKPOINT="pudb.set_trace"

source ~/.bash_aliases

export JULIA_NUM_THREADS=4

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dstanczak/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dstanczak/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dstanczak/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dstanczak/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# Enable and load bashcompinit
autoload -Uz compinit bashcompinit
compinit
bashcompinit
# Argcomplete explicit registration for pubs
eval "$(register-python-argcomplete pubs)"
export SUDO_EDITOR=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim
#compdef toggl
_toggl() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _TOGGL_COMPLETE=complete-zsh  toggl)
}
if [[ "$(basename -- ${(%):-%x})" != "_toggl" ]]; then
  compdef _toggl toggl
fi



export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

# added by travis gem
[ ! -s /home/dstanczak/.travis/travis.sh ] || source /home/dstanczak/.travis/travis.sh



# if [[ -z "$TMUX" ]] ;then
#     ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session
#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
# fi
#

export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/cuda
export DISABLE_AUTO_TITLE=true

# Konsole color changing
theme-night() {
  switch-term-color "colors=Solarized"
}
theme-light() {
  switch-term-color "colors=SolarizedLight"
}
switch-term-color() {
  arg="${1:-colors=SolarizedLight}"
  if [[ -z "$TMUX" ]]
  then
    konsoleprofile "$arg"
  else
    printf '\033Ptmux;\033\033]50;%s\007\033\\' "$arg"
  fi
}

# currenttime=$(date +%H:%M)
# if [[ "$currenttime" > "19:00" ]] || [[ "$currenttime" < "06:30" ]]; then
#     theme-night
# else
#     theme-light
# fi
export MANPAGER='nvim +Man!'

function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.env ]] ; then
# source ./.env/bin/activate  # commented out by conda initialize
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}

export WORKON_HOME=~/Envs
eval `dircolors ~/.dir_colors`

# Environment file for all projects.

preexec() { print -Pn "\e]0;$1%~\a" }

