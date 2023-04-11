#!/bin/sh

set -eu

ASDF_VERSION="v0.11.3"
ASDF_BIN=~/.asdf/asdf.sh

sudo dnf install curl git
if [ ! -d ~/.asdf ] ; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$ASDF_VERSION"
fi

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

/bin/sh "$ASDF_BIN" plugin add python https://github.com/danhper/asdf-python.git
/bin/sh "$ASDF_BIN" install python latest
