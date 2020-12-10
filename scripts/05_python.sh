#!/bin/sh
set -o errexit
set -xv

DESKTOP_PYTHON_VERSION=3.8.6
DIR_PYENV=~/.pyenv

git clone https://github.com/pyenv/pyenv.git $DIR_PYENV || echo "Already checked out"

# initialize pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ ! -e $DIR_PYENV/versions/${DESKTOP_PYTHON_VERSION}/bin/python ] ; then
    pyenv install $DESKTOP_PYTHON_VERSION
fi
pyenv global $DESKTOP_PYTHON_VERSION

for i in ~/.zshrc ~/.bashrc ; do
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $i
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $i
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $i
done

eval "$(pyenv init -)"
pip install --upgrade pip
pip install pipenv
