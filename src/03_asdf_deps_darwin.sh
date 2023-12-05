#!/bin/sh

set -eu

ASDF_BIN=~/.asdf/asdf.sh

brew install curl git

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
brew install openssl readline sqlite3 xz zlib tcl-tk

