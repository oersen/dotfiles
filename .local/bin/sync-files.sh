#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

dest="/run/media/$USER/usbdrive32gb"
rsync_opts="--archive --delete-after --inplace --hard-links --verbose"

while getopts ":d:n" opt; do
    case "$opt" in
        "d" )
            dest="$OPTARG"
            ;;

        "n" )
            rsync_opts="$rsync_opts --dry-run"
            ;;
    esac
done

[ -d "$dest" ] && [ -w "$dest" ] || die "$dest: directory not accessible"

rsync $rsync_opts "$HOME/Documents" "$HOME/Pictures" "$dest"

df -h "$dest" | tr -s ' ' '\t' | cut -f 2-
