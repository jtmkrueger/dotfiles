#!/bin/bash
#
# simplebat
# =======
#
# By John Krueger
#
# This script is customized for my razer blade pro. It returns
# a battery percentage. Nice for the tmux status bar.

POWER=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | sed -n -e 's/^.*percentage:          //p ')
TIME=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "time to empty" | sed -n -e 's/^.*time to empty:       //p ')
CHARGING=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "icon-name" | sed -n -e 's/^.*icon-name:          //p ' | grep -oh charging)

# this is wacky, but forces the string to be a number
PERCENTLESS=$((${POWER%?} + 0))
if [ "$PERCENTLESS" -ge 1 -a "$PERCENTLESS" -le 12 ]; then POWERBAR=▁;
elif [ "$PERCENTLESS" -ge 13 -a "$PERCENTLESS" -le 24 ]; then POWERBAR=▂;
elif [ "$PERCENTLESS" -ge 25 -a "$PERCENTLESS" -le 36 ]; then POWERBAR=▃;
elif [ "$PERCENTLESS" -ge 37 -a "$PERCENTLESS" -le 48 ]; then POWERBAR=▄;
elif [ "$PERCENTLESS" -ge 49 -a "$PERCENTLESS" -le 60 ]; then POWERBAR=▅;
elif [ "$PERCENTLESS" -ge 61 -a "$PERCENTLESS" -le 72 ]; then POWERBAR=▆;
elif [ "$PERCENTLESS" -ge 73 -a "$PERCENTLESS" -le 84 ]; then POWERBAR=▇;
elif [ "$PERCENTLESS" -ge 85 -a "$PERCENTLESS" -le 100 ]; then POWERBAR=█; fi

# are we charging?
if [ $CHARGING == 'charging' ]; then
  CHARGEICON=🗲;
else
  CHARGEICON=±;
fi

printf "%s" " $CHARGEICON $POWERBAR $POWER $TIME"
