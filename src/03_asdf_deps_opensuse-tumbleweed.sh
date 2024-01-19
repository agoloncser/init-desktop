#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

sudo zypper install -y curl git

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo zypper install -y make gcc zlib-devel bzip2 libbz2-devel readline-devel sqlite3 sqlite3-devel libopenssl-devel tk-devel libffi-devel xz-devel


