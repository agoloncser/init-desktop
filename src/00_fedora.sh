#!/bin/sh
set -euxv

if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    sudo dnf upgrade -y
fi
sudo dnf install -y git curl python3 ansible gnupg2 tmux pipenv gnupg-pkcs11-scd pcsc-lite-ccid pcsc-lite xz rsync bash pass pass-otp fish wl-clipboard freerdp2 pipenv
sudo systemctl enable pcscd
sudo systemctl start pcscd
