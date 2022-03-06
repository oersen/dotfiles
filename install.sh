#!/bin/sh

mkdir -pm 0700 \
    "${XDG_CACHE_HOME:-"$HOME/.cache"}" \
    "${XDG_CONFIG_HOME:-"$HOME/.config"}" \
    "${XDG_DATA_HOME:-"$HOME/.local/share"}" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}/mpd" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}/vim"

case "$SHELL" in
    *"termux"* )
        pkg upgrade
        apt autoremove

        pkg install \
            bash-completion curl exiv2 fzf git jq man nmap openssh vim \
            cmatrix cowsay figlet fortune ncurses-utils neofetch nyancat sl

        exit
        ;;
esac

on="$(tput setaf 2)"
off="$(tput sgr0)"

pretty_print() {
    printf "%s[%s]%s\n" "$on" "$*" "$off"
}

pretty_print "add 'rpm fusion' repositories"
sudo dnf install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

pretty_print "install necessary packages"
sudo dnf install \
    @c-development \
    @fonts \
    @libreoffice \
    @networkmanager-submodules \
    @printing \
    android-tools \
    asciiquarium \
    atool \
    avahi-tools \
    bash-completion \
    bind-utils \
    blueman \
    boxes \
    brightnessctl \
    bsd-games \
    calcurse \
    cifs-utils \
    cmatrix \
    cowsay \
    dbus-tools \
    dnscrypt-proxy \
    espeak-ng \
    ethtool \
    exfatprogs \
    ffmpeg \
    figlet \
    firefox \
    foot \
    fortune-mod \
    fzf \
    galculator \
    git \
    gnome-themes-extra \
    grimshot \
    gstreamer1-libav \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-freeworld \
    gstreamer1-plugins-good \
    gstreamer1-plugins-good-extras \
    gstreamer1-plugins-ugly \
    gstreamer1-plugins-ugly-free \
    gstreamer1-vaapi \
    gvfs-mtp \
    gvfs-smb \
    igt-gpu-tools \
    ImageMagick \
    imv \
    irssi \
    iwl6000g2b-firmware \
    jq \
    libva-intel-driver \
    libva-utils \
    lolcat \
    lshw \
    lsof \
    lynx \
    mako \
    man-pages \
    mesa-dri-drivers \
    microcode_ctl \
    mlocate \
    mozilla-ublock-origin \
    mpc \
    mpd \
    mpv \
    mtr \
    ncdu \
    ncmpcpp \
    neofetch \
    network-manager-applet \
    NetworkManager-openvpn \
    NetworkManager-tui \
    newsboat \
    nicotine+ \
    nmap \
    nyancat \
    pandoc \
    papirus-icon-theme \
    parallel \
    pass \
    pavucontrol \
    pciutils \
    pcmanfm \
    perl \
    perl\(Image::ExifTool\) \
    perl\(Perl::Critic\) \
    perl\(Perl::Tidy\) \
    pinentry-gnome3 \
    pipewire-pulseaudio \
    pipewire-utils \
    podman \
    polkit-gnome \
    power-profiles-daemon \
    pulseaudio-utils \
    pv \
    qgnomeplatform \
    ranger \
    rng-tools \
    rsync \
    screen \
    ShellCheck \
    simple-scan \
    sl \
    smartmontools \
    swappy \
    sway \
    swayidle \
    swaylock \
    symlinks \
    tcpdump \
    telnet \
    tmux \
    translate-shell \
    transmission-daemon \
    udiskie \
    unrar \
    usbutils \
    util-linux-user \
    vim-enhanced \
    vim-perl-support \
    vim-X11 \
    waybar \
    wdisplays \
    wev \
    wf-recorder \
    whois \
    wl-clipboard \
    wlr-randr \
    wlsunset \
    wofi \
    words \
    wshowkeys \
    yt-dlp \
    zathura-pdf-mupdf \
    zip

pretty_print "upgrade all packages"
sudo dnf upgrade
sudo dnf autoremove

pretty_print "disable services"
sudo systemctl disable --now ModemManager.service sshd.service
