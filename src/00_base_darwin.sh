#!/bin/sh
set -eu

INSTALL_FAST=${INSTALL_FAST:=""}

# installing homebrew
HOMEBREW_BIN=/opt/homebrew/bin/brew
case $(uname -a) in
    *x86_64) HOMEBREW_BIN=/usr/local/bin/brew ;;
    *arm64) HOMEBREW_BIN=/opt/homebrew/bin/brew ;;
    *) exit 1 ;;
esac

if [ ! -x "$HOMEBREW_BIN" ] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo Homebrew already installed
fi

brew update

if [ -z "$INSTALL_FAST" ] ; then
    brew upgrade
fi

brew install \
    curl \
    fish \
    git \
    gnupg \
    mosh \
    openssh \
    pass \
    pass-otp \
    tmux

brew install --cask \
     gpg-suite-no-mail \
     emacs

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
brew install \
    openssl \
    readline \
    sqlite3 \
    tcl-tk \
    zlib
