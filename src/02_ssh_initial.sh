#!/usr/bin/env bash

set -eu

mkdir "$HOME/.ssh" || true
chmod 0700 "$HOME/.ssh"

if [ -d "$HOME/.ssh/config" ] ;then
    echo "$HOME/.ssh/config directory exists, exiting."
    exit 0
fi

cat <<EOF > "$HOME/.ssh/config"
Host github.com
HostName github.com
IdentitiesOnly yes
IdentityFile ~/.ssh/ed25519-github-%L-%u
User git
EOF
