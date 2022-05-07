#!/bin/sh
set -euxv

sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y git python3 curl ansible gnupg2 pass tmux pipenv scdaemon pcscd xz-utils bash rsync pass-extension-otp fish pipenv
sudo systemctl enable pcscd
sudo systemctl start pcscd
