#!/bin/bash
#
# moonphase
# =======
#
# By John Krueger
#
# This script sends a request to retrieve the current moon phase, and returns an
# appropriate emoji. Nice for the tmux status bar.
#
# You're going to need to install jq with your package manager

set -e

moon_icon() {
  case $1 in
    "Dark Moon") echo 🌑
      ;;
    "New Moon") echo 🌑
      ;;
    "Waxing Crescent") echo 🌒
      ;;
    "1st Quarter") echo 🌓
      ;;
    "Waxing Gibbous") echo 🌔
      ;;
    "Full Moon") echo 🌕
      ;;
    "Waning Gibbous") echo 🌖
      ;;
    "3rd Quarter") echo 🌗
      ;;
    "Waning Crescent") echo 🌘
      ;;
    *) echo "$1"
  esac
}

DATE=`date +%s`
API=$(curl --silent http://farmsense-prod.apigee.net/v1/moonphases/?d="$DATE")

MOON=$(echo "$API" | jq --raw-output .[0].Moon[0])
PHASE=$(echo "$API" | jq --raw-output .[0].Phase)
ICON=$(moon_icon "$PHASE")

printf "%s" "$MOON $ICON "
