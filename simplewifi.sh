#!/bin/bash
# check if nmcli exists
if ! [ -x "$(command -v nmcli)" ]; then
output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
airport=$(echo "$output" | grep 'AirPort' | awk -F': ' '{print $2}')

if [ "$airport" = "Off" ]; then
    echo -e "󰢿"
else
    signal=$(echo "$output" | grep 'agrCtlRSSI' | awk -F': ' '{print $2}')
    ssid=$(echo "$output" | grep ' SSID' | awk -F': ' '{print $2}')
    speed=$(echo "$output" | grep 'lastTxRate' | awk -F': ' '{print $2}')

    if [ "$signal" -gt -60 ]; then
        sigicon="󰢾"
    elif [ "$speed" -gt -90 ]; then
        sigicon="󰢽"
    else
        sigicon="󰢼"
    fi

    echo -e "${sigicon} ${ssid} ${speed} Mb/s"
fi
else
  nmcli -f BARS,SSID -t dev wifi | sed 's/:/ /g'
fi
