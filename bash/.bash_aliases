alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

alias youtube-mp3='yt-dlp -x --audio-format=mp3 --audio-quality=0 --embed-thumbnail --add-metadata'
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
	if [ -x "$(command -v nvr)" ]; then
		alias nvim=nvr
	else
		alias nvim='echo "No nesting!"'
	fi
fi
alias wttr='curl wttr.in/Warsaw'
alias git-remove-squashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias git-delete-squashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

function masters-pages() {
	pdfinfo ~/Writing/Magisterium/build/pracaMagisterska.pdf | grep Pages | awk '{print $2}'
}

# Konsole color changing
theme-night() {
	switch-term-color "colors=Solarized"
}
theme-light() {
	switch-term-color "colors=SolarizedLight"
}
switch-term-color() {
	arg="${1:-colors=Solarized}"
	if [[ -z "$TMUX" ]]; then
		konsoleprofile "$arg"
	else
		printf '\033Ptmux;\033\033]50;%s\007\033\\' "$arg"
	fi
}

function lightmode() {
	~/.local/share/light-mode.d/gtk-theme.sh
	~/.local/share/light-mode.d/kde-theme.sh
	~/.local/share/light-mode.d/konsole-theme.sh
}

function darkmode() {
	~/.local/share/dark-mode.d/gtk-theme.sh
	~/.local/share/dark-mode.d/kde-theme.sh
	~/.local/share/dark-mode.d/konsole-theme.sh
}

alias termdownsay='termdown -v us-mbrola-1'
alias jl="julia --sysimage ~/.julia/config/sys_plots.so"
alias twork="toggl now -a Work"
alias tbathroom="toggl start -o Bathroom Łazienka"
alias plasmalogout="qdbus org.kde.ksmserver /KSMServer logout 0 3 3"
alias chrome="google-chrome-stable"

function festsay() {
	speech="(SayText \"$*\")"
	festival -b '(voice_cmu_us_rms_cg)' $speech
}

function tbreak() {
	toggl start -a Work -o Relax Break
	if termdownsay "$1m"; then
		echo "Break going overlong?"
		toggl start -o Relax "Break (overlong?)"
	else
		echo "Break completed."
	fi
}

countdown() {
	date1=$(($(date +%s) + $1))
	while [ "$date1" -ge $(date +%s) ]; do
		## Is this more than 24h away?
		days=$(($(($(($date1 - $(date +%s))) * 1)) / 86400))
		echo -ne "$days day(s) and $(date -u --date @$(($date1 - $(date +%s))) +%H:%M:%S)\r"
		sleep 0.1
	done
}
stopwatch() {
	date1=$(date +%s)
	while true; do
		days=$(($(($(date +%s) - date1)) / 86400))
		echo -ne "$days day(s) and $(date -u --date @$(($(date +%s) - $date1)) +%H:%M:%S)\r"
		sleep 0.1
	done
}

alias noexit='set -o ignoreeof'
alias plasma-panel-toggle='qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.height = 32 - p.height;"'
alias lofi='mpv --no-video $(youtube-dl -g https://www.youtube.com/watch\?v=5qap5aO4i9A)'
alias mux='tmuxinator'
alias bee='beeminder'

alias profileoff="grep -rli '@profile' plasmapy | xargs -i\"}\" sed -i 's/@profile/#profile/g' \"}\""
alias profileon="grep -rli '#profile' plasmapy | xargs -i\"}\" sed -i 's/#profile/@profile/g' \"}\""

posprzatane() {
	sprzatanie done $*
	# beeminder u largecleaning 1 "$*"
}
alias pacorphans="pacman -Qqtd "
if command -v exa &>/dev/null; then
	alias ls=exa
fi
if ! command -v bat &>/dev/null; then
	alias cat=bat
fi
alias klastermount="sshfs klaster:/home/dstanczak /mnt/klaster -o idmap=user,auto_cache,reconnect,Cipher=no -oauto_cache,reconnect"
alias klastermountdisable="fusermount -u /mnt/klaster"

alias jrnl='nvim -c VimwikiMakeDiaryNote -c ZenMode'
alias vimwiki='nvim -c "Telescope vimwiki"'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias pacdiff="DIFFPROG='nvim -d' pacdiff"
alias toggl-today='toggl ls -s $(date -I)'
alias nbx="jupyter nbconvert --execute --to notebook"
LOCAL_ALIASES="~/.aliases_local"
if [ -f "$LOCAL_ALIASES" ]; then
	source $LOCAL_ALIASES
fi
alias sync_conflicts='fd "sync-conflict"'
alias nvimtutor="nvim --clean +Tutor"

# fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
