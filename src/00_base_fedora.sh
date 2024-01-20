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

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo dnf install -y \
    bzip2 \
    bzip2-devel \
    gcc \
    libffi-devel \
    make \
    openssl-devel \
    readline-devel \
    sqlite \
    sqlite-devel \
    tk-devel \
    xz-devel \
    zlib-devel

sudo systemctl enable pcscd
sudo systemctl start pcscd
