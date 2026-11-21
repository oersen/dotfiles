#!/bin/sh

subject="$1"
IFS="+"

shift

curl -sSL "https://cht.sh/$subject${*:+"/$*"}"
