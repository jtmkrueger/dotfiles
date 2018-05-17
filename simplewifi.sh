#!/bin/bash
nmcli -f BARS,SSID -t dev wifi | sed 's/:/ /g'
