#!/bin/bash

summary() {
    printf "\n\nSUMMARY: correctly guessed %i out of %i words\n" "$won" "$rounds"
}

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

file="/usr/share/dict/words"
won="0"
rounds="0"
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
    letters=""
    steps="${#word}"
    partial="$(tr -c "\n$letters" "_" <<<"$word")"

    printf "[ROUND %i]\n" "$(( ++rounds ))"

    while true; do
        printf "Steps from the gallows (%i): [" "$steps"

        for (( i = 0; i < steps; ++i )); do
            printf "#"
        done

        for (( i = 0; i < ${#word} - steps; ++i )); do
            printf "-"
        done

        printf "]\nThe word so far: %s\n" "$partial"

        if [[ -n "$letters" ]]; then
            printf "(Guessed: %s) " "$letters"
        fi

        read -rp "Guess a letter: " guess

        if [[ "$guess" == "$word" ]]; then
            printf "You can go now! Found the word: '%s'\n\n" "$word"
            (( ++won ))
            break
        elif (( ${#guess} != 1 )); then
            printf "Guess only one letter at a time\n"
        elif [[ "$letters" == *"$guess"* ]]; then
            printf "Tried '%s' before\n" "$guess"
        elif [[ "$word" == *"$guess"* ]]; then
            letters="$(sed 's/./&\n/g' <<<"$letters$guess" | sort | tr -d '\n')"
            partial="$(tr -c "\n$letters" "_" <<<"$word")"

            if [[ "$partial" == "$word" ]]; then
                printf "You can go now! Found the word: '%s'\n\n" "$word"
                (( ++won ))
                break
            else
                printf "The letter '%s' is found in the word\n" "$guess"
            fi
        elif (( steps == 1 )); then
            printf "End of the line! Could not found the word '%s'\n\n" "$word"
            break
        else
            letters="$(sed 's/./&\n/g' <<<"$letters$guess" | sort | tr -d '\n')"

            printf "Try again! The letter '%s' does not appear in the word\n" "$guess"
            (( --steps ))
        fi
    done
done
