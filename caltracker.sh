#!/bin/bash
#
# caltracker
# =======
#
# By John Krueger
#
# This script prints the number of hours and minutes until the next calendar event.
# It uses icalbuddy to get the next event and then parses the output to get the time
# unitl the event. It prints the time until the event in the format "H:MM" or "MM" if
# the event is less than an hour away. If the event is occuring now, it prints "NOW".
# If there are no upcoming events today, it returns a nice little message.
#
# SETUP
# 1. Install icalbuddy with your package manager of choice (homebrew, apt-get, etc.)
# 2. Add this script to your path
# 3. Add the following line to your tmux status bar:
#   #{caltracker}

set -e

# Get the next event name on first line and time on second line from icalbuddy
next_event=$(icalbuddy -n -b "" -ea -li 1 -iep "title,datetime" -tf "%H:%M" eventsToday)

# Get the event name from the first line
event_name=$(echo "$next_event" | head -n 1)

# Get the event start time in seconds since epoc from the second line
event_start=$(echo "$next_event" | tail -n 1 | awk -F' - ' '{gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1); print $1}')
event_start_seconds=$(date -j -f "%H:%M" "$event_start" +"%s")

# Get the event end time in seconds since epoc from the second line
event_end=$(echo "$next_event" | tail -n 1 | awk -F' - ' '{gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); print $2}')
event_end_seconds=$(date -j -f "%H:%M" "$event_end" +"%s")

# Get the current time in seconds since epoch
current_time=$(date +%s)

# Get the time until the event in seconds
# If the event is happening now, the time until the event is 0
time_until_event=$((event_start_seconds - current_time))

# If the event is happening now, print "NOW"
# If the event is happening in less than an hour, print the number of minutes until the event
# If the event is happening in more than an hour, print the number of hours and minutes until the event
# If there are no events today, print a nice message
if [ "$event_name" = "No Events Today" ]; then
  echo "󰧒 No More Events Today"
elif [ "$time_until_event" -le 0 ] && [ "$event_end_seconds" -gt "$current_time" ]; then
  echo "󰧓 $event_name NOW"
elif [ "$time_until_event" -le 3600 ]; then
  echo "󰃰 $event_name in $((time_until_event / 60))m"
else
  echo "󰃰 $event_name in $((time_until_event / 3600))h $(((time_until_event % 3600) / 60))m"
fi
