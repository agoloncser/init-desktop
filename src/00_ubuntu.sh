#!/bin/sh
set -o errexit
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y git python3 curl ansible gnupg2 pass tmux pipenv scdaemon pcscd xz-utils bash rsync pass-extension-otp fish
sudo systemctl enable pcscd
sudo systemctl start pcscd
