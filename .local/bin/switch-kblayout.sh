#!/bin/sh

layout="$(printf "%s\n" "tr" "tr(f)" "us" | wofi -dL 4)" || exit

notify-send -i settings -t 4000 "keyboard layout: $layout"

swaymsg input type:keyboard xkb_layout "$layout"
