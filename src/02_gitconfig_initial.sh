#!/usr/bin/env bash

set -eu

if [ -d "$HOME/.ssh" ] ;then
    echo ".gitconfig exists, exiting."
    exit 0
fi

cat <<EOF > "$HOME/.gitconfig"
[credential]
	helper = cache
[core]
	autocrlf = false
[init]
	defaultBranch = main
[alias]
	root = rev-parse --show-toplevel
[ghq]
	root = ~/src
[credential "https://github.com"]
	username = agoloncser
	helper = "!f() { test \"$1\" = get && echo \"password=$(pass pat/github.com/agoloncser/git)\"; }; f"
EOF


