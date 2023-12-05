#!/bin/sh

set -eu

DIR=$(dirname $0)

case $(uname -s) in
    Linux)
        source /etc/os-release
        bash "$DIR/03_asdf_deps_${ID}.sh"
        ;;
    Darwin)
        bash "$DIR/03_asdf_deps_darwin.sh"
        ;;
     *)
         echo "Unsupported OS."
         exit 1
         ;;
esac
