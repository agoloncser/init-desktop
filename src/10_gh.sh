#!/bin/sh
#
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md#opensusesuse-linux-zypper

set -eu

echo "Installing Github CLI..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        case $ID in
            opensuse*)
                sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
                sudo zypper ref
                sudo zypper install gh
                ;;
            ubuntu)
                sudo apt update && sudo apt install curl -y
                curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
                && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
                && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
                && sudo apt update \
                && sudo apt install gh -y
                ;;
            fedora)
                sudo dnf install 'dnf-command(config-manager)'
                sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
                sudo dnf install gh
                ;;
            *)
                echo "Unsupported distro."
                exit 0 ;;

        esac

        ;;
    Darwin) brew install gh ;;
    *)
         echo "Unsupported OS."
         exit 0
         ;;
esac
