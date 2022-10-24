#!/usr/bin/env sh

## Set up login keyring
# see https://unix.stackexchange.com/a/295652/332452
#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
#eval "$(/usr/bin/gnome-keyring-daemon --start)"
#export SSH_AUTH_SOCK

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
#mkdir -p "$HOME"/.local/share/keyrings

## launch WM
awesome

## launch kde plasma
#export DESKTOP_SESSION=plasma
#exec startplasma-x11
