#!/bin/sh

dot="$(slurp -pb 00000000)" || exit
color="$(grim -g "$dot" - | convert - txt:- | awk 'END { print $3 }')"

wl-copy "$color"

notify-send -i color-select -t 8000 "'$color' copied to clipboard!"
