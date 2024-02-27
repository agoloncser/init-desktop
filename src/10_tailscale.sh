#!/bin/sh
#
# https://tailscale.com/download/linux/opensuse-tumbleweed

set -eu

echo "Installing Tailscale..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        if [ -z "$VERSION_CODENAME" ] ; then
            echo "ERROR: Cannot detect distro version."
        fi
        case $ID in
            opensuse*)
                sudo zypper ar -g -r https://pkgs.tailscale.com/stable/opensuse/tumbleweed/tailscale.repo
                sudo zypper ref
                sudo zypper in -y tailscale
                ;;
            ubuntu)
                curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.noarmor.gpg" | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
                curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.tailscale-keyring.list" | sudo tee /etc/apt/sources.list.d/tailscale.list
                sudo apt-get update
                sudo apt-get install -y tailscale
                ;;
            fedora)
                sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
                sudo dnf install -y tailscale
                ;;
            *)
                echo "Unsupported distro."
                exit 0 ;;

        esac
        sudo systemctl enable --now tailscaled
        ;;
    Darwin) brew install --cask resilio-sync ;;
    *)
         echo "Unsupported OS."
         exit 0
         ;;
esac
