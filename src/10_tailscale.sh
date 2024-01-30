#!/bin/sh
#
# https://tailscale.com/download/linux/opensuse-tumbleweed

set -eu

echo "Installing Tailscale..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        case $ID in
            opensuse*)
                sudo zypper ar -g -r https://pkgs.tailscale.com/stable/opensuse/tumbleweed/tailscale.repo
                sudo zypper ref
                sudo zypper in -y tailscale
                ;;
            # ubuntu)
            #     echo "TODO"
            #     exit 0 ;;
            #     ;;
            fedora)
                sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
                sudo dnf install tailscale
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
