#!/bin/sh

sha1sum "$@" "/dev/null" 2>"/dev/null" \
    | awk '{
                if (count[$1]++ == 0) first[$1] = $0
                if (count[$1] == 2) print first[$1]
                if (count[$1] > 1) print $0
           }' \
    | sort \
    | awk '{
                if (last != $1) print ""
                last = $1
                print $0
           }'
