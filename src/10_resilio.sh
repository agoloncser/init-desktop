#!/bin/sh
#
# https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux

set -eu

echo "Installing Resilio Sync..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        case $ID in
            opensuse*)
                sudo rpm --import https://linux-packages.resilio.com/resilio-sync/key.asc
                sudo zypper ar --gpgcheck-allow-unsigned-repo -f https://linux-packages.resilio.com/resilio-sync/rpm/\$basearch resilio-sync || true
                sudo zypper install resilio-sync
                ;;
            ubuntu)
                sudo apt-get install -y wget
                echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
                wget -qO- https://linux-packages.resilio.com/resilio-sync/key.asc | sudo tee /etc/apt/trusted.gpg.d/resilio-sync.asc > /dev/null 2>&1
                sudo apt-get install -y resilio-sync
                ;;
            fedora)
                sudo rpm --import https://linux-packages.resilio.com/resilio-sync/key.asc
                printf "[resilio-sync]\nname=Resilio Sync\nbaseurl=https://linux-packages.resilio.com/resilio-sync/rpm/\$basearch\nenabled=1\ngpgcheck=1\n" | sudo tee /etc/yum.repos.d/resilio-sync.repo
                sudo dnf install resilio-sync
                ;;
            *)
                echo "Unsupported distro."
                exit 0 ;;

        esac
        sudo systemctl disable resilio-sync || true
        systemctl --user enable resilio-sync
        systemctl --user start resilio-sync
        ;;
    Darwin) brew install --cask resilio-sync ;;
    *)
         echo "Unsupported OS."
         exit 0
         ;;
esac
