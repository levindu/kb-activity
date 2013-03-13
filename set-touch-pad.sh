#!/bin/bash

set_touch_pad () {
    declare -i ACTION
    ACTION=$1
    if [ $ACTION -eq 1 ]
    then
        xinput set-int-prop $ID "Device Enabled" 8 1
        xinput set-int-prop $ID  "Evdev Wheel Emulation" 8 1
        xinput set-int-prop $ID  "Evdev Wheel Emulation Button" 8 2
        xinput set-int-prop $ID  "Evdev Middle Button Emulation" 8 1
        echo "Touchpad enabled."
    else
        xinput set-int-prop $ID "Device Enabled" 8 0
        echo "Touchpad disabled."
    fi
}

TOUCH_PAD_NAME="PS/2 Generic Mouse"
if [ -f /etc/default/touch-pad ]; then
    . /etc/default/touch-pad
fi

declare -i ID
ID=$(xinput list | sed -n "s~.*${TOUCH_PAD_NAME}.*id=\([0-9]\+\).*~\1~p")

declare -i STATE
STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`

if [ $STATE -eq 1 -a \( -z "$1" -o "$1" == "0" \) ]; then
    set_touch_pad 0
elif [ $STATE -eq 0 -a \( -z "$1" -o "$1" == "1" \) ]; then
    set_touch_pad 1
else
    echo "Do nothing"
fi
