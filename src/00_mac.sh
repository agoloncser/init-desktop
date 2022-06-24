#!/bin/sh
set -euxv

# installing homebrew
if [ ! -x /usr/local/bin/brew ] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo Already installed
fi

brew update
brew upgrade
brew install git ansible gnupg curl pass tmux openssh xz rsync pass pass-otp mas fish pipenv
