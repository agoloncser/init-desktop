#!/bin/sh
set -o errexit
sudo dnf upgrade -y
sudo dnf install -y git curl python3 ansible gnupg2 tmux pipenv gnupg-pkcs11-scd pcsc-lite-ccid pcsc-lite xz rsync bash pass pass-otp fish wl-clipboard freerdp2
sudo systemctl enable pcscd
sudo systemctl start pcscd
