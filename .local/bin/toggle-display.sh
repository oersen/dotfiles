#!/bin/sh

swaymsg -t get_outputs | jq -e '[.[].dpms] | any' \
    && swaymsg "output * dpms off" \
    || swaymsg "output * dpms on"
