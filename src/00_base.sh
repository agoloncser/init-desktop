#!/bin/sh

set -eu

DIR=$(dirname $0)

case $(uname -s) in
    Linux)
        source /etc/os-release
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
