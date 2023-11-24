#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

# Fix asdf variable unbound errors
ZSH_VERSION=""
ASDF_DOWNLOAD_PATH="$(mktemp -d)"
export ZSH_VERSION
export ASDF_DOWNLOAD_PATH

. "$ASDF_BIN"

set +eu
asdf plugin add ghq    https://github.com/kajisha/asdf-ghq.git || true
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add python https://github.com/danhper/asdf-python.git || true
set -eu

grep '\.asdf\/asdf.sh' $HOME/.bashrc ||
cat <<EOF >> $HOME/.bashrc
# Load ASDF - desktop-init-scripts
. "$HOME/.asdf/asdf.sh"
EOF

cp shared/asdf/.default-python-packages "$HOME/.default-python-packages"
cp shared/asdf/.default-npm-packages "$HOME/.default-npm-packages"
cp shared/asdf/.tool-versions "$HOME/.tool-versions"

echo "Update asdf..."
asdf update
asdf plugin-update --all 

echo "Install asdf tools..."
asdf install

echo "Update python packages..."
pip install --upgrade pip
pip install --user -r "$HOME/.default-python-packages"

echo "Update npm packages..."
npm update -g npm
xargs npm update --global < "$HOME/.default-npm-packages"


