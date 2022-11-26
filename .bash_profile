export \
    XDG_CACHE_HOME="$HOME/.cache" \
    XDG_CONFIG_HOME="$HOME/.config" \
    XDG_DATA_HOME="$HOME/.local/share" \
    XDG_STATE_HOME="$HOME/.local/state"

export \
    EDITOR="vim" PAGER="less" VISUAL="vim" \
    GROFF_NO_SGR="1" \
    INPUTRC="$XDG_CONFIG_HOME/readline/inputrc" \
    NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config" \
    PARALLEL_HOME="$XDG_CONFIG_HOME/parallel" \
    PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store" \
    PATH="${PATH:+"$PATH:"}$HOME/.local/bin" \
    SCREENRC="$XDG_CONFIG_HOME/screen/screenrc" \
    WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

if [ "$(tty)" = "/dev/tty1" ]; then
    export \
        MOZ_ENABLE_WAYLAND="1" \
        NO_AT_BRIDGE="1" \
        QT_QPA_PLATFORMTHEME="gnome" \
        SDL_VIDEODRIVER="wayland" \
        XDG_CURRENT_DESKTOP="sway" \
        XDG_SESSION_DESKTOP="sway" \
        XDG_SESSION_TYPE="wayland" \
        _JAVA_AWT_WM_NONREPARENTING="1"

    exec sway >"/dev/null" 2>&1
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
