#!/bin/sh

pass_dir="${PASSWORD_STORE_DIR:-"$HOME/.password-store"}"
selection="$(find "$pass_dir" -name "*.gpg" | sed "s:\\.gpg::; s:$pass_dir/::" | wofi -d)" || exit
password="$(pass "$selection")" || exit

wl-copy -o "$password"

notify-send -i password-copy -t 8000 "copied to clipboard: '$selection'"
