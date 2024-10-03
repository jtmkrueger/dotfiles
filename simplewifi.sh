#!/bin/bash
# check if nmcli exists
if ! [ -x "$(command -v nmcli)" ]; then
  # Get the name of the current Wi-Fi interface
  interface=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')
  
  # Get the RSSI value for the current Wi-Fi connection
  rssi=$(networksetup -getinfo "$interface" | awk '/Wi-Fi/{print $2}')
  
  # Convert the RSSI value to a signal quality percentage
  signal=$((2 * (rssi + 100)))
  
  # Get the SSID of the current Wi-Fi connection
  ssid=$(networksetup -getairportnetwork "$interface" | awk -F': ' '{print $2}')
  
  # Get the total bytes sent and received
  bytes=$(netstat -ibn | grep -e "$interface" -m 1 | awk '{print $7 + $10}')

  # Convert bytes to megabits
  megabits=$(echo "scale=2; $bytes / 125000" | bc)
  
  if [ "$signal" -gt -60 ]; then
    sigicon="󰢾"
  elif [ "$signal" -gt -90 ]; then
    sigicon="󰢽"
  else
    sigicon="󰢼"
  fi

  echo -e "${sigicon} ${ssid} ${megabits}Mb/s"
else
  nmcli -f BARS,SSID -t dev wifi | sed 's/:/ /g'
fi
