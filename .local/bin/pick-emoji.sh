#!/bin/sh

file="${XDG_STATE_HOME:-"$HOME/.local/state"}/emoji.txt"

while getopts ":r" opt; do
    case "$opt" in
        "r" )
            curl -sSL "https://www.unicode.org/Public/emoji/latest/emoji-test.txt" | sed -ne 's/^.*; fully-qualified.*# \([^[:space:]]*\) [^[:space:]]* \(.*$\)/\1 \2/gp' >"$file"
            exit
            ;;
    esac
done

[ -r "$file" ] || notify-send -i state-warning -t 8000 "$file: file not readable"

selection="$(wofi -dW 30% <"$file")" || exit

wl-copy "${selection%%[[:space:]]*}"
wl-copy -p "${selection#*[[:space:]]}"

notify-send -i color-select -t 8000 "copied to clipboard: '${selection%%[[:space:]]*}'"
