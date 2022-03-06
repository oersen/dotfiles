#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

count="8"

while getopts ":c:" opt; do
    case "$opt" in
        "c" )
            case "$OPTARG" in
                *[![:digit:]]* )
                    die "$OPTARG: invalid count"
                    ;;

                * )
                    count="${OPTARG##"0"}"
                    ;;
            esac
            ;;
    esac
done

shift "$(( OPTIND - 1 ))"

for file in "${@:-"/dev/stdin"}"; do
    [ -r "$file" ] || die "$file: file not readable"

    printf "%s:\n" "$file"

    tr -cs "[:alpha:]'" '\n' <"$file" \
        | tr '[:upper:]' '[:lower:]' \
        | sort \
        | uniq -c \
        | sort -k1,1nr -k2 \
        | head -n "$count"
done
