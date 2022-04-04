#!/bin/sh

printf "%s\n" \
    "save output" \
    "save screen" \
    "save active" \
    "save window" \
    "save area" \
    "copy output" \
    "copy screen" \
    "copy active" \
    "copy window" \
    "copy area" \
    | wofi -dL 10 \
    | xargs grimshot --notify
