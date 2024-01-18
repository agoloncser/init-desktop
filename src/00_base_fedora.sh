#!/bin/sh
set -euxv

INSTALL_FAST=${INSTALL_FAST:=""}

if [ -z "$INSTALL_FAST" ] ; then
    sudo dnf upgrade -y
fi

sudo dnf install -y \
    bash \
    curl \
    fish \
    freerdp \
    git \
    git-credential-oauth \
    gnupg-pkcs11-scd \
    gnupg2 \
    mosh \
    pass \
    pass-otp \
    pcsc-lite \
    pcsc-lite-ccid \
    rsync \
    tmux \
    wl-clipboard \
    xz \
    zsh


sudo systemctl enable pcscd
sudo systemctl start pcscd
