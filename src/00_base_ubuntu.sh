#!/bin/sh
set -euxv

INSTALL_FAST=${INSTALL_FAST:=""}

sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt-get update -y

if [ -z "$INSTALL_FAST" ] ; then
    sudo apt-get upgrade -y
fi

sudo apt-get install -y \
    bash \
    curl \
    fish \
    freerdp2-x11 \
    gconf2 \
    git \
    gnupg2 \
    mosh \
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
