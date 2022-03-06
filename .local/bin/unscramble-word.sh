#!/bin/bash

summary() {
    printf "\n\nSUMMARY: found %i out of %i scrambled words\n" "$won" "$rounds"
}

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

file="/usr/share/dict/words"
rounds="0"
won="0"
declare -l guess word

while getopts ":f:" opt; do
    case "$opt" in
        "f" )
            file="$OPTARG"
            ;;
    esac
done

if [[ ! -r "$file" ]]; then
    die "$file: file not readable"
fi

trap 'summary' EXIT

while true; do
    word="$(shuf -n 1 "$file")"
    scrambled="$(sed 's/./&\n/g' <<<"$word" | shuf | tr -d '\n')"
    n="0"

    printf "[ROUND %i]\nWord to unscramble: %s\n" "$(( ++rounds ))" "$scrambled"

    while true; do
        read -rp "Guess the word (next): " guess

        case "$guess" in
            "$word" )
                printf "Correct (%i)! Found it with %i tries\n\n" "$(( ++won ))" "$(( ++n ))"
                break
                ;;

            "next" )
                printf "The word is '%s', the number of tries is %i\n\n" "$word" "$n"
                break
                ;;

            * ) printf "Try again (%i)!\n" "$(( ++n ))" ;;
        esac
    done
done
