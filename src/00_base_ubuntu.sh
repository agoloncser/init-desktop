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
    gconf2 \
    git \
    gnupg2 \
    mosh \
    pass \
    pass-extension-otp \
    pcscd \
    rsync \
    scdaemon \
    tmux

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt-get install -y \
    bash \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev

sudo systemctl enable pcscd
sudo systemctl start pcscd
