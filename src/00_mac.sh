#!/bin/sh
set -o errexit

dir="$HOME/.homebrew"

# installing homebrew
if [ ! -x "$dir/bin/brew" ] ; then
    git clone https://github.com/Homebrew/brew "$dir"
else
    echo Already installed
fi

eval "$($dir/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

brew update
brew upgrade
brew install git ansible gnupg curl pass tmux openssh xz rsync pass pass-otp mas fish
