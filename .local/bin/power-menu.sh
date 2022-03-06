#!/bin/sh

swaynag \
    -t "default" -m " [ $USER@${HOSTNAME:-"$(hostname)"} ] " \
    -Z " suspend" "systemctl suspend" \
    -Z " reboot" "systemctl reboot" \
    -Z " poweroff" "systemctl poweroff" \
    -Z " logout" "loginctl terminate-user $USER" \
    -Z " lock" "swaylock"
