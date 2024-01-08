#!/usr/bin/env bash

set -eu

if [ -d "$HOME/.gitconfig" ] ;then
    echo ".gitconfig exists, exiting."
    exit 0
fi

cp share/gitconfig "$HOME/.gitconfig"

