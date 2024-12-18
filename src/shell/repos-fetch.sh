#!/usr/bin/env bash

# Fetch unpushed repos, requires `ghq` to get the list of repositories
set -eu
while read -r repo ; do
    git -C "$repo" fetch || true
done < <(ghq list --full-path)
