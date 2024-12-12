#!/bin/sh

#
# Wrapper script to add entries to known_hosts via ssh-keyscan
#

set -eu
ssh-keyscan "$1" | tee -a "$HOME/.ssh/known_hosts"
