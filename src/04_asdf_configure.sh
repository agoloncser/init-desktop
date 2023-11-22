#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

# Fix asdf variable unbound errors
ZSH_VERSION=""
ASDF_DOWNLOAD_PATH="$(mktemp -d)"
export ZSH_VERSION
export ASDF_DOWNLOAD_PATH

source "$ASDF_BIN"

set +eu
asdf plugin add ghq    https://github.com/kajisha/asdf-ghq.git || true
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add python https://github.com/danhper/asdf-python.git || true
set -eu

cat <<EOF > "$HOME/.default-python-packages"
ansible-core
pipenv
yamllint
EOF

grep '\.asdf\/asdf.sh' $HOME/.bashrc ||
cat <<EOF >> $HOME/.bashrc
# Load ASDF - desktop-init-scripts
. "$HOME/.asdf/asdf.sh"
EOF

cp shared/.default-python-packages "$HOME/.default-python-packages"
cp shared/.tool-versions "$HOME/.tool-versions"

asdf update
asdf plugin-update --all 
asdf install
