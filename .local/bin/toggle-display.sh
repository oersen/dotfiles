#!/bin/sh

read -r lcd <"/tmp/lcd"

if [ "$lcd" != "1" ]; then
    swaymsg "output * dpms off"
    echo "1" >"/tmp/lcd"
else
    swaymsg "output * dpms on"
    echo "0" >"/tmp/lcd"
fi
