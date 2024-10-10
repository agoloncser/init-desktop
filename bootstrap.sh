#!/bin/sh

set -eu

echo "Bootstrapping system..."

case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        case $ID in
            ubuntu)
                sudo apt-get update
                sudo apt-get install -y git make
            ;;
            fedora)
                sudo dnf install -y git make
            ;;
            *) echo "Unsupported distro: $ID"
               exit 1
               ;;
        esac
        ;;
    Darwin)
        xcode-select --install
        ;;
    FreeBSD)
        pkg install -y git gmake fish tmux sudo
        ;;
    *)
        echo "Unsupported OS."
        exit 1
        ;;
esac

cat <<EOF
Now run:

    make install

EOF
