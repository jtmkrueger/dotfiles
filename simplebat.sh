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
  if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 14 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 15 -a "$PERCENTLESS" -le 29 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 30 -a "$PERCENTLESS" -le 44 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 45 -a "$PERCENTLESS" -le 59 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 60 -a "$PERCENTLESS" -le 74 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 75 -a "$PERCENTLESS" -le 89 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 90 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=; fi
else
  if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 14 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 15 -a "$PERCENTLESS" -le 29 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 30 -a "$PERCENTLESS" -le 44 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 45 -a "$PERCENTLESS" -le 59 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 60 -a "$PERCENTLESS" -le 74 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 75 -a "$PERCENTLESS" -le 89 ]; then POWERBAR=;
  elif [ "$PERCENTLESS" -ge 90 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=; fi
fi

printf "%s" "$POWERBAR $PERCENTLESS% ($TIME)";
