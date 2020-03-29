#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
source ~/.keysrc

# https://eklitzke.org/using-gpg-agent-effectively
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"

PATH="${PATH}:/home/dominik/.local/bin"

# Created by `userpath` on 2020-03-23 13:35:42
export PATH="$PATH:/home/dominik/.local/bin"
