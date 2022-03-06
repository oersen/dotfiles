#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

file="$HOME/Downloads/com.google.android.gms_20187.apk"

while getopts ":f:" opt; do
    case "$opt" in
        "f" )
            file="$OPTARG"
            ;;
    esac
done

[ "${file##*"."}" = "apk" ] && [ -r "$file" ] || die "$file: invalid file"

adb root || exit
adb remount || exit
adb push "$file" "/system/app/" || exit
adb shell chmod 644 "/system/app/${file##*"/"}"
