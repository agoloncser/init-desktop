#!/bin/sh
set -o errexit
sudo dnf upgrade -y
sudo dnf install -y git curl python3 ansible gnupg2 pass tmux pipenv gnupg-pkcs11-scd pcsc-lite-ccid pcsc-lite xz

sudo systemctl enable pcscd
sudo systemctl start pcscd
