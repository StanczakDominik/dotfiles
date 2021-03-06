#!/usr/bin/bash

STATE=""
BAT="BAT1"
MAXFREQ="G"

if [[ "$1" == "BAT" || "$1" == "AC" ]]; then
  STATE="$1"
fi

if [[ $STATE == "" ]]; then
  if [[ $(acpi -a | cut -d' ' -f3) == "on-line" ]]; then
    STATE="AC"
  else STATE="BAT"
  fi
fi

echo $STATE

if [[ $STATE == "BAT" ]]; then
  echo "Discharging, set governor to powersave"
  powertop --auto-tune
  cpupower frequency-set -u $MAXFREQ
  echo "Disable Syncthing"
  systemctl --user stop syncthing
  echo "Stop Docker"
  systemctl stop docker
elif [[ $STATE == "AC"  ]]; then
  echo "AC plugged in, set governor to performance"
  cpupower frequency-set -u $MAXFREQ
  echo "Start Syncthing"
  systemctl --user start syncthing
  echo "Start Docker"
  systemctl start docker
fi
