#!/bin/sh
set -o errexit
set -xv

cd scripts && {
    sh 00_mac.sh -n
    sh 05_python.sh
}
python --version
ansible --version
