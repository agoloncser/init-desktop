#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

sudo dnf install curl git
if [ ! -d ~/.asdf ] ; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

