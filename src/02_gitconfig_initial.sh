#!/usr/bin/env bash

set -eu

git config --global credential.helper cache
git config --global alias.root "rev-parse --show-toplevel"
git config --global ghq.root ~/src

_configure_oauth(){
    echo "Configure git-credential-oauth"
    git credential-oauth configure
}

case $(uname -s) in
    Darwin) _configure_oauth ;;
    Linux)
        . /etc/os-release
        case $ID in
            fedora) _configure_oauth ;;
            ubuntu)  echo "WARNING: setup the HTTPS authentication according to README.md manually."
                exit 0
                ;;
            *)  echo "Unsupported OS: $ID"
                exit 1
                ;;
        esac
    ;;
    *) echo "Unsupported OS: $(uname -s)"
       exit 1
    ;;
esac
