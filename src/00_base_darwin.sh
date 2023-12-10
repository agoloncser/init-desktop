#!/bin/sh
set -eu

DESKTOP_INIT_SKIP_UPGRADE=${DESKTOP_INIT_SKIP_UPGRADE:=""}

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

if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    brew upgrade
fi

brew install \
    curl \
    fish \
    git \
    gnupg \
    mas \
    openssh \
    pass \
    pass-otp \
    rsync \
    tmux
