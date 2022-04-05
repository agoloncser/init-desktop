#!/bin/sh
set -o errexit

dir="$HOME/.homebrew"

# installing homebrew
if [ ! -x "$dir/bin/brew" ] ; then
    git clone https://github.com/Homebrew/brew $dir
else
    echo Already installed
fi

"$dir/bin/brew" update
"$dir/bin/brew" upgrade
"$dir/bin/brew" install git ansible gnupg curl pass tmux openssh xz rsync pass pass-otp mas fish
