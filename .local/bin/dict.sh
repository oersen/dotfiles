#!/bin/sh

query="dict://dict.org/"

while getopts ":ds" opt; do
    case "$opt" in
        "d" )
            query="${query}define:"
            ;;

        "s" )
            query="${query}show:databases:"
            ;;
    esac
done

shift "$(( OPTIND - 1 ))"

IFS=":"

curl -sS "$query$*"
