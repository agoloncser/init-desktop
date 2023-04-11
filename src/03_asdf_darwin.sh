#!/bin/sh

set -eu

ASDF_VERSION="v0.11.3"
ASDF_BIN=~/.asdf/asdf.sh

brew install curl git
if [ ! -d ~/.asdf ] ; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$ASDF_VERSION"
fi

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
brew install openssl readline sqlite3 xz zlib tcl-tk

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

"$ASDF_BIN" plugin add python https://github.com/danhper/asdf-python.git
"$ASDF_BIN" install python latest

