[ -z "$PS1" ] && return
[ -f "/etc/bashrc" ] && . "/etc/bashrc"

stty -ixon
umask 0022
shopt -s cdspell direxpand dirspell

on="\[$(tput bold; tput setaf 7)\]"
off="\[$(tput sgr0)\]"
PS1="$on> \w <$off "
PS2="$on>$off "
unset on off

GLOBIGNORE=".git:*.swp"
HISTCONTROL="ignoreboth:erasedups"
HISTFILE="${XDG_STATE_HOME:-"$HOME/.local/state"}/bash_history"
HISTIGNORE="?:??:???:????"
HISTSIZE="65536"
HISTTIMEFORMAT="[%c]  "

alias \
    abook='abook -C "$XDG_CONFIG_HOME/abook/abookrc" -f "$XDG_DATA_HOME/abook/addressbook"' \
    cp='cp -iv' \
    dotfiles='git --git-dir="$XDG_DATA_HOME/dotfiles" --work-tree="$HOME"' \
    ip='ip -c' \
    iperl='RLWRAP_HOME=$XDG_STATE_HOME rlwrap -A -pWHITE -S"perl> " perl -wnE'\''say eval()//$@'\' \
    irssi='irssi --config="$XDG_CONFIG_HOME/irssi/config" --home="$XDG_DATA_HOME/irssi"' \
    ls='ls --color=auto --group-directories-first' \
    mbsync='mbsync -c "$XDG_CONFIG_HOME/isync/mbsyncrc"' \
    mv='mv -iv' \
    rm='rm -Iv'

clean_history() {
    local number pattern

    if [ -n "$1" ]; then
        for pattern in "$@"; do
            for number in $(history | awk -v "p=$pattern" '$0 ~ p { print $1 }' | sort -nr); do
                history -d "$number"
            done
        done
    else
        for number in $(history | perl -ne 's/\s+$//; s/(^\d+).*]\s+//; print "$1\n" if $cmdline{$_}++' | sort -nr); do
            history -d "$number"
        done
    fi
}
