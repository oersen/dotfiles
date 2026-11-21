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

while getopts ":lr" opt; do
    case "$opt" in
        "l" )
            cat "$file" 2>"/dev/null" || die "$file: file not readable"
            exit
            ;;

        "r" )
            curl -sSL "https://ascii.live/list" | jq -r '.frames[]' >"$file"
            exit
            ;;
    esac
done

[ -r "$file" ] || die "$file: file not readable"

frame="${1:-"rick"}"

if grep -qx "$frame" "$file"; then
    trap 'reset_term' EXIT

    tput smcup
    tput civis

    curl -sSL "https://ascii.live/$frame"
else
    die "$frame: invalid frame"
fi
