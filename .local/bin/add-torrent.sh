#!/bin/sh

pidof transmission-daemon >"/dev/null" \
    || { transmission-daemon --log-error -e "/dev/null"; sleep 1; }

transmission-remote -a "$@" || exit

notify-send -i browser-download -t 8000 "'$*' added to transmission!"
