#!/bin/bash

file_path="$1"
pv_width="$2"
file_extension="${file_path##*"."}"
file_extension_lower="${file_extension,,}"
mimetype="$(file -bL --mime-type -- "$file_path")"

case "$mimetype" in
    audio/*|image/*|video/*)
        exiftool -- "$file_path" && exit 5 ;;

    *html)
        lynx -dump -- "$file_path" && exit 5 ;;

    *json)
        jq -C . "$file_path" && exit 5 || exit 2 ;;

    *torrent)
        transmission-show -- "$file_path" && exit 5 ;;

    text/*|*csv|*xml)
        [ "$(stat --printf='%s' -- "$file_path")" -gt 262144 ] && exit 2
        highlight -q -t 8 -s pablo -O xterm256 -- "$file_path" && exit 5 || exit 2 ;;
esac

case "$file_extension_lower" in
    a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
    rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|7z)
        atool -l -- "$file_path" && exit 5 ;;

    apk|iso|djvu|epub|mobi|pdf|ps|odt|ods|odp|sxw)
        exiftool -- "$file_path" && exit 5 ;;
esac

printf 'File Type Classification\n========================\n\n'
file -bL -- "$file_path" | sed -E "s/(.{$pv_width})/\1\n/g" && exit 5 || exit 1
