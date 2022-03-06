#!/bin/sh

IFS="+"
query="https://wttr.in/$*"

[ "${COLUMNS:-"$(tput cols)"}" -lt 125 ] && query="$query?n"

curl -sS --compressed "$query"
