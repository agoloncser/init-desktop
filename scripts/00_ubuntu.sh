#!/bin/sh
set -o errexit
set -xv
flag_n=
while getopts n options
do
    case $options in
        n) flag_n=1 ;;
    esac
done
set -xv
if [ -z "$flag_n" ] ; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
fi
sudo apt-get install -y network-manager-openvpn

# pyenv
sudo apt-get install -y git libssl-dev libreadline-dev libbz2-dev libsqlite3-dev libffi-dev curl build-essential zlib1g-dev
