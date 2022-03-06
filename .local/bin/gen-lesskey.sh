#!/bin/sh

die() {
    printf "${0##*"/"}: %s\n" "$@" >&2
    exit 1
}

bold="4"
underline="2"
reset="$(tput sgr0)"
hstfile="${XDG_STATE_HOME:-"$HOME/.local/state"}/lesshst"

while getopts ":b:u:" opt; do
    case "$opt" in
        "b" )
            case "$OPTARG" in
                *[![:digit:]]* )
                    die "$OPTARG: invalid color"
                    ;;

                * )
                    bold="${OPTARG##"0"}"
                    ;;
            esac
            ;;

        "u" )
            case "$OPTARG" in
                *[![:digit:]]* )
                    die "$OPTARG: invalid color"
                    ;;

                * )
                    underline="${OPTARG##"0"}"
                    ;;
            esac
            ;;
    esac
done

cat >"${XDG_CONFIG_HOME:-"$HOME/.config"}/lesskey" <<EOF
#env
LESS            = -dgiMnR
LESSHISTFILE    = $hstfile
LESS_TERMCAP_md = $(tput bold; tput setaf "$bold")
LESS_TERMCAP_me = $reset
LESS_TERMCAP_us = $(tput smul; tput setaf "$underline")
LESS_TERMCAP_ue = $reset
LESS_TERMCAP_so = $(tput setab 7; tput setaf 0)
LESS_TERMCAP_se = $reset
EOF
