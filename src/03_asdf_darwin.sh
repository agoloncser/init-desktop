#!/bin/sh

set -eu
brew install curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
brew install openssl readline sqlite3 xz zlib tcl-tk

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python latest

