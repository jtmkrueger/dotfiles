#!/bin/bash
#
# moonphase
# =======
#
# By John Krueger
#
# This script calculates current moon phase, and returns an
# appropriate emoji. Nice for the tmux status bar.

set -e

lp=2551443
now=$(date -u +"%s")
newmoon=592500
phase=$((($now - $newmoon) % $lp))
phase_number=$((((phase / 86400) + 1)*100000))

if   [ $phase_number -lt 184566 ];  then phase_icon="🌚" name="new"
elif [ $phase_number -lt 553699 ];  then phase_icon="🌒"  name="waxing crescent"
elif [ $phase_number -lt 922831 ];  then phase_icon="🌓"  name="first quarter"
elif [ $phase_number -lt 1291963 ];  then phase_icon="🌔"  name="first quarter"
elif [ $phase_number -lt 1661096 ]; then phase_icon="🌝"  name="full"
elif [ $phase_number -lt 2030228 ]; then phase_icon="🌖" name="waning gibbous" 
elif [ $phase_number -lt 2399361 ]; then phase_icon="🌗"  name="last quarter"
elif [ $phase_number -lt 2768493 ]; then phase_icon="🌘"  name="waning crescent"
else
  phase_icon="🌚"  name="new"
fi
echo $phase_icon $name
