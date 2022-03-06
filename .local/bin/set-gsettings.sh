#!/bin/sh

gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'full'
gsettings set org.gnome.desktop.interface font-name 'Sans 11'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 11'
gsettings set org.gnome.desktop.wm.preferences button-layout ''
gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita-dark'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Sans 11'
gsettings set org.gnome.desktop.default-applications.terminal exec 'foot'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
