#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

file="/dev/urandom"
char_set="[:graph:]"
length="96"

while getopts ":c:l:" opt; do
    case "$opt" in
        "c" )
            case "$OPTARG" in
                alnum|alpha|digit|graph|lower|punct|upper|xdigit )
                    char_set="[:$OPTARG:]"
                    ;;

                ?-? )
                    char_set="$OPTARG"
                    ;;

                * )
                    die "$OPTARG: invalid character set"
                    ;;
            esac
            ;;

        "l" )
            case "$OPTARG" in
                *[![:digit:]]* )
                    die "$OPTARG: invalid length"
                    ;;

                * )
                    length="${OPTARG##"0"}"
                    ;;
            esac
            ;;
    esac
done

[ -r "$file" ] || die "$file: file not readable"

tr -cd "$char_set" <"$file"  2>"/dev/null" | head -c "$length"

[ -t 1 ] && printf "\n"
