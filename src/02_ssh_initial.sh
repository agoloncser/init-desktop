#!/usr/bin/env bash

set -eu

if [ -d "$HOME/.ssh" ] ;then
    echo ".ssh directory exists, exiting."
    exit 0
fi

mkdir "$HOME/.ssh"
chmod 0700 "$HOME/.ssh"
cat <<EOF > "$HOME/.ssh/config"
Host github.com
HostName github.com
IdentitiesOnly yes
IdentityFile ~/.ssh/ed25519-github-%L-%u
User git
EOF


