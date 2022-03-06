#!/bin/sh

subject="$1"
IFS="+"

shift

curl -sS "https://cht.sh/$subject${*:+"/$*"}"
