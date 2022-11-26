#!/bin/sh

swaymsg -t get_outputs | jq -e '[.[].dpms] | any' \
    && swaymsg "output * power off" \
    || swaymsg "output * power on"
