#!/bin/sh
set -o errexit
sudo dnf upgrade -y
sudo dnf install -y git curl python3 ansible gnupg2 pass
