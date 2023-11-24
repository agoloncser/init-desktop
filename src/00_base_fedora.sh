#!/bin/sh
set -euxv

DESKTOP_INIT_SKIP_UPGRADE=${DESKTOP_INIT_SKIP_UPGRADE:=""}

if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    sudo dnf upgrade -y
fi

sudo dnf install -y \
    bash \
    curl \
    fish \
    freerdp \
    git \
    gnupg-pkcs11-scd \
    gnupg2 \
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
