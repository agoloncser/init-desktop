#!/bin/sh
set -o errexit
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y git python3 curl ansible gnupg2 pass tmux pipenv scdaemon pcscd xz-utils bash rsync pass-extension-otp fish wl-clipboard freerdp2-x11
sudo systemctl enable pcscd
sudo systemctl start pcscd
