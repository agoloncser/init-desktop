#!/usr/bin/env bash

# Lists unpushed repos, requires `ghq` to get the list of repositories

set -eu

_color_bold=$(tput bold)
_color_off=$(tput sgr0)
while read -r repo ; do

    # Detect unpushed commits
    (git -C "$repo" status | grep 'Your branch is ahead of') >/dev/null 2>&1 && {
        echo -e "${_color_bold}${repo}${_color_off}"
        git -C "$repo" cherry -v
        git -C "$repo" branch -vvv
        echo
    }

    # Detect dirty repos
    clean=$(git -C "$repo" status --porcelain)
    if [ -n "$clean" ] ; then
        cat <<EOF
$repo
$clean

EOF
    fi
done < <(ghq list --full-path)
