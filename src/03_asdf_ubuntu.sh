#!/bin/sh

set -eu
apt install curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

cat <<EOF > "$HOME/.default-python-packages"
ansible
pipenv
EOF

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python latest
