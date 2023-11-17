#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

source $ASDF_BIN
asdf plugin add ghq    https://github.com/kajisha/asdf-ghq.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python https://github.com/danhper/asdf-python.git

cat <<EOF > "$HOME/.default-python-packages"
ansible-core
pipenv
EOF

cp ../shared/.tool-versions $HOME/.tool-versions

asdf install
