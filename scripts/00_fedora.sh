#!/bin/sh
set -o errexit
flag_n=
while getopts n options
do
    case $options in
        n) flag_n=1 ;;
    esac
done

set -xv
if [ -z "$flag_n" ] ; then
    sudo dnf update -y
    sudo dnf upgrade -y
fi
sudo dnf install -y git

# pyenv
sudo dnf -y install git gcc findutils make zlib-devel openssl-devel readline-devel bzip2-devel sqlite-devel libffi-devel curl
