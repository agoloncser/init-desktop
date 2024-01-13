#!/bin/sh
set -euxv

SKIP_UPGRADE=${SKIP_UPGRADE:=""}

if [ -z "$SKIP_UPGRADE" ] ; then
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
