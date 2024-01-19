#!/bin/sh
set -euxv

INSTALL_FAST=${INSTALL_FAST:=""}

if [ -z "$INSTALL_FAST" ] ; then
    sudo zypper dup -y
fi

    ## missing packages
    #git-credential-oauth \
    #gnupg-pkcs11-scd \
sudo zypper install -y \
    bash \
    curl \
    fish \
    freerdp \
    git \
    gpg2 \
    mosh \
    password-store \
    pass-otp \
    pcsc-lite \
    pcsc-ccid \
    rsync \
    tmux \
    wl-clipboard \
    xz \
    zsh


sudo systemctl enable pcscd
sudo systemctl start pcscd

