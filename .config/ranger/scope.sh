#!/bin/bash

file_path="$1"
file_extension="${file_path##*"."}"
pv_width="$2"

case "$(file -bL --mime-type -- "$file_path")" in
    audio/*|image/*|video/*)
        exiftool -- "$file_path" && exit 5 ;;

    *html)
        lynx -dump -width="$pv_width" -- "$file_path" && exit 4 ;;

    *json)
        jq -C . "$file_path" && exit 5 ;;

    *torrent)
        transmission-show -- "$file_path" && exit 5 ;;

    *troff)
        MANWIDTH="$pv_width" man -- "$file_path" && exit 4 ;;

    text/*|*csv|*json|*xml)
        [ "$(stat --printf='%s' -- "$file_path")" -gt 262144 ] && exit 2
        highlight -q -t 8 -s pablo -O xterm256 -- "$file_path" && exit 5 || exit 2 ;;
esac

case "${file_extension,,}" in
    a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
    rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|7z)
        atool -l -- "$file_path" && exit 5 ;;

    apk|iso|djvu|epub|mobi|pdf|ps|odt|ods|odp|sxw)
        exiftool -- "$file_path" && exit 5 ;;
esac

printf 'File Type Classification\n========================\n\n'
file -bL -- "$file_path" | sed -E "s/(.{$pv_width})/\1\n/g" && exit 4 || exit 1
