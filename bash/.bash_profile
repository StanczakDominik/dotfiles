#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
source ~/.keysrc

# https://eklitzke.org/using-gpg-agent-effectively
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"

export PATH="${PATH}:/home/dominik/.local/bin"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source $HOME/.local/bin/virtualenvwrapper.sh

# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
