#!/usr/bin/env bash

set -eu

# Prepare a commit message with listing the files in the commit.

for file in $(git diff HEAD  --name-only) ; do
cat <<EOF
fix($(basename $file)):

EOF
done > "$1"
