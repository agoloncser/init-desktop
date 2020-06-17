#!/bin/sh
set -o errexit
set -xv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
python --version
ansible --version
