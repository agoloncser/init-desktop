#!/usr/bin/env bash

set -eu

mkdir "$HOME/.ssh" || true
chmod 0700 "$HOME/.ssh"

if [ -d "$HOME/.ssh/config" ] ;then
    echo "$HOME/.ssh/config directory exists, exiting."
    exit 0
fi

cp shared/ssh_config.conf "$HOME/.ssh/config"
