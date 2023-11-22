#!/bin/sh
set -euxv

DESKTOP_INIT_SKIP_UPGRADE=${DESKTOP_INIT_SKIP_UPGRADE:=""}

# installing homebrew
if [ ! -x /usr/local/bin/brew ] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo Already installed
fi

brew update
if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    brew upgrade
fi
brew install git ansible gnupg curl pass tmux openssh xz rsync pass pass-otp mas fish pipenv
