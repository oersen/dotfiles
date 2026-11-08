#!/bin/sh

file="${XDG_STATE_HOME:-"$HOME/.local/state"}/emoji.txt"
selection="$(wofi -dW 30% <"$file")" || exit

wl-copy "${selection%%[[:space:]]*}"
wl-copy -p "${selection#*[[:space:]]}"

notify-send -i color-select -t 8000 "copied to clipboard: '${selection%%[[:space:]]*}'"
