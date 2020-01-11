alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias ls='ls --color=auto'
# alias vimjrnl="vim ~/.jrnl/$(date --rfc-3339=date).md"
alias youtube-mp3='youtube-dl -x --audio-format=mp3 --audio-quality=0 --embed-thumbnail --add-metadata'
# alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias open="xdg-open"
alias dualscreen="xrandr --output VIRTUAL1 --auto --right-of eDP1"
alias vim=nvim
alias vi=nvim
# alias todoist='todoist --color --indent'
# alias todo='todoist --color --indent list --filter "today"'
# alias todo-linux='unbuffer todoist --color --indent list --filter "today & @Linux" | less -R'
# alias todo='todoist list --filter "overdue | today"'
#alias todo-linux='unbuffer todoist list --filter "today & @Linux" | less -R'
# alias todo-linux='todoist list --filter "today & @Linux"'
alias vimwiki='cd ~/vimwiki; vim -c VimwikiIndex'
alias vimwiki-todo="cd ~/vimwiki; rg '\[\s\]|TODO'  ~/vimwiki/"
# TODO make vimwiki-todo a function with default argument ~/vimwiki
alias vimwiki-html="cd ~/vimwiki/public; python3 -m http.server"

alias phone="scrcpy -b2M -m800"
alias phone-connect="adb connect 192.168.1.100:5555"
alias jupylab="/progs/miniconda3/bin/jupyter-lab"
alias jupylab-pass="/progs/miniconda3/bin/jupyter notebook list"
alias sympy="/progs/miniconda3/bin/ipython --profile sympy"
#alias ipython="/progs/miniconda3/bin/ipython"

# alias openbox_dualscreen="xrandr --auto --output HDMI-0 --mode 1920x1080 --right-of eDP-1-1"
alias plasmapy="cd ~/Code/github/PlasmaPy/PlasmaPy; conda activate plasmapy"
alias pythonpic="cd ~/Code/PythonPIC; conda activate pythonpic"
alias nbody="cd ~/Code/NBody-MD/; conda activate nbody37"

alias checklist='voila /home/dominik/Code/HabitIncrementer/checklist.ipynb'
alias newsreader='voila /home/dominik/Code/PaperSubscription/newsreader.ipynb --port=8897'
alias wttr='curl wttr.in'
alias sendmusic='beet mv -d /mnt/hdd/Music_beets/\!CurrentTopMusic'
alias git-remove-squashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias jrnl='check habit :wrench: Journal/microblog; jrnl'
alias prep_dedalus="export LD_LIBRARY_PATH=/progs/miniconda3/envs/dedalus/lib"
