#!/bin/sh

set -eu

DIR="$(dirname "$0")"

INSTALL_FAST=${INSTALL_FAST:=""}
if [ -n "$INSTALL_FAST" ] ; then
    echo "WARNING: INSTALL_FAST variable set, not doing updates."
fi

echo "Create directories..."
for i in $HOME/src $HOME/tmp ; do
    mkdir -p "$i" || true
done

echo "Installing packages..."
case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        bash "$DIR/00_base_${ID}.sh"
        ;;
    Darwin)
        bash "$DIR/00_base_darwin.sh"
        ;;
     *)
         echo "Unsupported OS."
         exit 1
         ;;
esac
