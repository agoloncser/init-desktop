#!/bin/bash
set -o errexit
set -xv
sh scripts/00_mac.sh -n
sh scripts/05_python.sh
sh tests/tests.sh
