#!/bin/sh
#
# https://support.1password.com/install-linux/

set -eu

echo "Installing 1password..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        case $ID in
            opensuse*)
                sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
                sudo zypper addrepo https://downloads.1password.com/linux/rpm/stable/x86_64 1password || true
                sudo zypper install -y 1password
                ;;
            ubuntu)
                sudo apt-get update
                sudo apt-get install -y curl
                curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

                echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
                sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
                curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
                sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
			    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

			    sudo apt-get update && sudo apt-get install -y 1password
                ;;
            fedora)
                sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
                sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
                sudo dnf install -y 1password
                ;;
            *)
                echo "Unsupported distro."
                exit 0 ;;
        esac
        ;;
    Darwin) brew install --cask 1password ;;
    *)
         echo "Unsupported OS."
         exit 0
         ;;
esac
