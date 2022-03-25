#!/bin/sh
set -o errexit

# installing homebrew
if [ ! -x $HOME/.brew/bin/brew ] ; then
    git clone https://github.com/Homebrew/brew.git $HOME/.brew
    $HOME/.brew/bin/brew tap homebrew/core
else
    echo Already installed
fi

export PATH=$HOME/.brew/bin:$PATH
brew update
brew upgrade
brew install git ansible gnupg curl pass tmux openssh xz rsync pass pass-otp mas fish
