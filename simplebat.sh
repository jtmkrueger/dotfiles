#!/bin/bash
#
# simplebat
# =======
#
# By John Krueger
#
# This script is for macs. It returns
# a battery percentage. Nice for the tmux status bar.

POWER=$(pmset -g batt | grep present | awk '{ print $3 }' )
TIME=$(pmset -g batt | grep present | awk '{ print $5 }' )
CHARGING=$(pmset -g batt | grep present | awk '{ print $4 }' )

# this is wacky, but forces the string to be a number
PERCENTLESS=$((${POWER%??}))

# are we charging?
if [[ $CHARGING != 'discharging;' ]]; then
  if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 10 ]; then POWERBAR=󰢜;
  elif [ "$PERCENTLESS" -ge 11 -a "$PERCENTLESS" -le 20 ]; then POWERBAR=󰂆;
  elif [ "$PERCENTLESS" -ge 21 -a "$PERCENTLESS" -le 30 ]; then POWERBAR=󰂇;
  elif [ "$PERCENTLESS" -ge 31 -a "$PERCENTLESS" -le 40 ]; then POWERBAR=󰂈;
  elif [ "$PERCENTLESS" -ge 41 -a "$PERCENTLESS" -le 50 ]; then POWERBAR=󰢝;
  elif [ "$PERCENTLESS" -ge 51 -a "$PERCENTLESS" -le 60 ]; then POWERBAR=󰂉;
  elif [ "$PERCENTLESS" -ge 61 -a "$PERCENTLESS" -le 70 ]; then POWERBAR=󰢞;
  elif [ "$PERCENTLESS" -ge 71 -a "$PERCENTLESS" -le 80 ]; then POWERBAR=󰂊;
  elif [ "$PERCENTLESS" -ge 81 -a "$PERCENTLESS" -le 90 ]; then POWERBAR=󰂋;
  elif [ "$PERCENTLESS" -ge 91 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=󰂅; fi
else
  if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 10 ]; then POWERBAR=󰁺;
  elif [ "$PERCENTLESS" -ge 11 -a "$PERCENTLESS" -le 20 ]; then POWERBAR=󰁻;
  elif [ "$PERCENTLESS" -ge 21 -a "$PERCENTLESS" -le 30 ]; then POWERBAR=󰁼;
  elif [ "$PERCENTLESS" -ge 31 -a "$PERCENTLESS" -le 40 ]; then POWERBAR=󰁽;
  elif [ "$PERCENTLESS" -ge 41 -a "$PERCENTLESS" -le 50 ]; then POWERBAR=󰁾;
  elif [ "$PERCENTLESS" -ge 51 -a "$PERCENTLESS" -le 60 ]; then POWERBAR=󰁿;
  elif [ "$PERCENTLESS" -ge 61 -a "$PERCENTLESS" -le 70 ]; then POWERBAR=󰂀;
  elif [ "$PERCENTLESS" -ge 71 -a "$PERCENTLESS" -le 80 ]; then POWERBAR=󰂁;
  elif [ "$PERCENTLESS" -ge 81 -a "$PERCENTLESS" -le 90 ]; then POWERBAR=󰂂;
  elif [ "$PERCENTLESS" -ge 91 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=󰁹; fi
fi

printf "%s" "$POWERBAR $PERCENTLESS% ($TIME)";
