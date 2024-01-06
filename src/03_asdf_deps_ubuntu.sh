#!/bin/sh

set -eu

sudo apt install -y curl git

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev bash
