#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
source ~/.keysrc

# https://eklitzke.org/using-gpg-agent-effectively
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"

export PATH="${PATH}:/home/dominik/.local/bin"
