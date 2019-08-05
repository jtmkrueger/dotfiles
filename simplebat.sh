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
if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 12 ]; then POWERBAR=▁;
elif [ "$PERCENTLESS" -ge 13 -a "$PERCENTLESS" -le 24 ]; then POWERBAR=▂;
elif [ "$PERCENTLESS" -ge 25 -a "$PERCENTLESS" -le 36 ]; then POWERBAR=▃;
elif [ "$PERCENTLESS" -ge 37 -a "$PERCENTLESS" -le 48 ]; then POWERBAR=▄;
elif [ "$PERCENTLESS" -ge 49 -a "$PERCENTLESS" -le 60 ]; then POWERBAR=▅;
elif [ "$PERCENTLESS" -ge 61 -a "$PERCENTLESS" -le 72 ]; then POWERBAR=▆;
elif [ "$PERCENTLESS" -ge 73 -a "$PERCENTLESS" -le 84 ]; then POWERBAR=▇;
elif [ "$PERCENTLESS" -ge 85 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=█; fi

# are we charging?
if [[ $CHARGING != 'discharging;' ]]; then
  CHARGEICON=⚡;
else
  CHARGEICON=;
fi

printf "%s" "$CHARGEICON$POWERBAR $TIME";
