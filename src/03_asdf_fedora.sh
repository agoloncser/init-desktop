#!/bin/sh

set -eu
sudo dnf install curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python latest
