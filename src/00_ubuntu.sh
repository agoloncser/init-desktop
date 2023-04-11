#!/bin/sh
set -euxv
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt update -y
if [ -z "$DESKTOP_INIT_SKIP_UPGRADE" ] ; then
    sudo apt upgrade -y
fi
sudo apt-get install -y git python3 curl ansible gnupg2 pass tmux pipenv scdaemon pcscd xz-utils bash rsync pass-extension-otp fish wl-clipboard freerdp2-x11 pipenv gconf2
sudo systemctl enable pcscd
sudo systemctl start pcscd
