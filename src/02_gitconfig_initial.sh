#!/usr/bin/env bash

set -eu

git config --global credential.helper cache
git config --global alias.root "rev-parse --show-toplevel"
git config --global ghq.root ~/src
