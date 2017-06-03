#!/bin/bash

upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | sed -n -e 's/^.*percentage:          //p'

