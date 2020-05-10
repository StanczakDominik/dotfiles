alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias ls='ls --color=auto'
alias youtube-mp3='youtube-dl -x --audio-format=mp3 --audio-quality=0 --embed-thumbnail --add-metadata'
alias vim=nvim
alias vi=nvim
alias todo='todoist --color --indent list --filter "today"'

alias phone="scrcpy -b2M -m800"
function phone-connect () {
    adb tcpip 5555
    adb connect $(ip neigh | grep 9c:e0:63:53:19:90 | cut -f 1 -d ' ' | head -n 1):5555
}


alias jupylab="/progs/miniconda3/bin/jupyter-lab"
alias jupylab-pass="/progs/miniconda3/bin/jupyter notebook list"
alias sympy="/progs/miniconda3/bin/ipython --profile sympy"

alias plasmapy="cd ~/Code/github/PlasmaPy/PlasmaPy"
alias pythonpic="cd ~/Code/PythonPIC"
alias nbody="cd ~/Code/NBody-MD/"

alias newsreader='voila /home/dominik/Code/PaperSubscription/newsreader.ipynb --port=8897'
alias wttr='curl wttr.in'
alias git-remove-squashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias git-delete-squashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias jrnl-review='jrnl -from "one month ago"'
alias blogging='cd ~/Writing/blog; vim in_progress/*'
function masters-pages () {
    pdfinfo ~/Writing/Magisterium/build/pracaMagisterska.pdf | grep Pages | awk '{print $2}'
}


function lightmode () {
    lookandfeeltool -a 'org.kde.breeze.desktop'
    kwriteconfig5 --file ~/.config/konsolerc --group "Desktop Entry" --key "DefaultProfile" "Light.profile"
    kwriteconfig5 --file ~/.config/yakuakerc --group "Desktop Entry" --key "DefaultProfile" "Light.profile"
    DISCORD_CONFIG="/home/dominik/.config/discord"
    jq '.BACKGROUND_COLOR = "#ffffff"' $DISCORD_CONFIG/settings.json > tmp.settings.json && mv tmp.settings.json $DISCORD_CONFIG/settings.json
    # TODO:
    # unify these two functions
    # firefox theme
    # treestyletabs theme
    # discord does not quite work...
}

function darkmode () {
    lookandfeeltool -a 'org.kde.breezedark.desktop'
    kwriteconfig5 --file ~/.config/konsolerc --group "Desktop Entry" --key "DefaultProfile" "Dark.profile"
    kwriteconfig5 --file ~/.config/yakuakerc --group "Desktop Entry" --key "DefaultProfile" "Dark.profile"
    DISCORD_CONFIG="/home/dominik/.config/discord"
    jq '.BACKGROUND_COLOR = "#202225"' $DISCORD_CONFIG/settings.json > tmp.settings.json && mv tmp.settings.json $DISCORD_CONFIG/settings.json
}
