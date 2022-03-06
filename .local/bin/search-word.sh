#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

file="/usr/share/dict/words"

while getopts ":f:" opt; do
    case "$opt" in
        "f" )
            file="$OPTARG"
            ;;
    esac
done

shift "$(( OPTIND - 1 ))"

[ -r "$file" ] || die "$file: file not readable"

grep -Ei "${1:-"."}" "$file" 2>"/dev/null" | sort -fu
