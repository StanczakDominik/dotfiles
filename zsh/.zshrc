# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
setopt appendhistory nomatch notify
stty -ixon
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dominik/.zshrc'
source /usr/share/zsh/scripts/zplug/init.zsh
zplug "Tarrasch/zsh-autoenv"
setopt completealiases

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



source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



source ~/.keysrc
source ~/.bashrc_local

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

source ~/.zsh_completion
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null
source "/usr/share/fzf/key-bindings.zsh"
# export FZF_DEFAULT_COMMAND='rg -L --files'
export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_DEFAULT_OPTS='--ansi'

# export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"

source ~/.bash_aliases

export JULIA_NUM_THREADS=4

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
export PATH="$HOME/Code/scripts:$HOME/Code/dotfiles/scripts:$HOME/.local/bin:$PATH:$HOME/.gem/ruby/2.7.0/bin"

eval $(thefuck --alias)

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dominik/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dominik/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dominik/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dominik/.miniconda3/bin:$PATH"
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
export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
#compdef toggl
_toggl() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _TOGGL_COMPLETE=complete-zsh  toggl)
}
if [[ "$(basename -- ${(%):-%x})" != "_toggl" ]]; then
  compdef _toggl toggl
fi

export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

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

export MANPAGER='nvim +Man!'

eval `dircolors ~/.dir_colors`

preexec() { print -Pn "\e]0;$1%~\a" }

# if tmux is executable, X is running, and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
#   [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
# fi


LIGHT_COLOR='base16-solarized-light.yml'
DARK_COLOR='base16-solarized-dark.yml'

alias day="alacritty-colorscheme -V apply $LIGHT_COLOR"
alias night="alacritty-colorscheme -V apply $DARK_COLOR"
alias toggle="alacritty-colorscheme -V toggle $LIGHT_COLOR $DARK_COLOR"
