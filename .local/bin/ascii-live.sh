#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

reset_term() {
    tput rmcup
    tput cnorm
}

file="${XDG_STATE_HOME:-"$HOME/.local/state"}/ascii-live.txt"

[ -r "$file" ] || curl -sS "https://ascii.live/list" | jq -r '.frames[]' >"$file"

while getopts ":l" opt; do
    case "$opt" in
        "l" )
            cat "$file"
            exit
            ;;
    esac
done

frame="${1:-"rick"}"

if grep -qx "$frame" "$file"; then
    trap 'reset_term' EXIT

    tput smcup
    tput civis

    curl -sS "https://ascii.live/$frame"
else
    die "$frame: invalid frame"
fi
