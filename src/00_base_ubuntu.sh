#!/bin/sh
set -euxv

DESKTOP_INIT_SKIP_UPGRADE=${DESKTOP_INIT_SKIP_UPGRADE:=""}

sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt update -y

if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    sudo apt upgrade -y
fi

sudo apt-get install -y \
    bash \
    curl \
    fish \
    freerdp2-x11 \
    gconf2 \
    git \
    gnupg2 \
    pass \
    pass-extension-otp \
    pcscd \
    rsync \
    scdaemon \
    tmux \
    wl-clipboard \
    zsh

sudo systemctl enable pcscd
sudo systemctl start pcscd
