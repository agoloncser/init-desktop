#!/bin/sh

set -eu

DIR="$(dirname "$0")"

echo "Create directories..."
for i in $HOME/src $HOME/tmp ; do
    mkdir -p "$i" || true
done

echo "Installing packages..."
case $(uname -s) in
    Linux)
        . /etc/os-release
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
