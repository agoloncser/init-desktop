#!/bin/sh
set -euxv

INSTALL_FAST=${INSTALL_FAST:=""}

sudo zypper ref

if [ -z "$INSTALL_FAST" ] ; then
    sudo zypper dup -y
fi

sudo zypper install -y \
    bash \
    curl \
    fish \
    git \
    gpg2 \
    mosh \
    password-store \
    pass-otp \
    pcsc-lite \
    pcsc-ccid \
    tmux

sudo zypper install -y \
    bzip2 \
    gcc \
    libbz2-devel \
    libffi-devel \
    libopenssl-devel \
    make \
    readline-devel \
    sqlite3 \
    sqlite3-devel \
    tk-devel \
    xz-devel \
    zlib-devel

sudo systemctl enable pcscd
sudo systemctl start pcscd

