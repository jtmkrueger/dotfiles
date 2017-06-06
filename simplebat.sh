#!/bin/bash
#
# simplebat
# =======
#
# By John Krueger
#
# This script is customized for my razer blade pro. It returns
# a battery percentage. Nice for the tmux status bar.

upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | sed -n -e 's/^.*percentage:          //p'

