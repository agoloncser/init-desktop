#!/bin/sh

set -eu

ASDF_VERSION="v0.11.3"
ASDF_BIN=~/.asdf/asdf.sh

sudo apt install curl git
if [ ! -d ~/.asdf ] ; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$ASDF_VERSION"
fi

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev bash

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

source "$ASDF_BIN"
asdf plugin add python https://github.com/danhper/asdf-python.git || true
asdf install python latest
