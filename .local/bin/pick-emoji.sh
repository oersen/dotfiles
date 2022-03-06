#!/bin/sh

file="${XDG_STATE_HOME:-"$HOME/.local/state"}/emoji.txt"
selection="$(wofi -d <"$file")" || exit

wl-copy "${selection%%[[:space:]]*}"
wl-copy -p "${selection##*[[:space:]]}"

notify-send -i color-select -t 8000 "copied to clipboard: '${selection%%[[:space:]]*}'"
