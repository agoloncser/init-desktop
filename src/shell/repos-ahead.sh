#!/usr/bin/env bash

# List repos containing branches ahead of remote

set -eu

_color_bold=$(tput bold)
_color_off=$(tput sgr0)
while read -r repo ; do
    (git -C "$repo" branch -v | grep '\[ahead [0-9]') >/dev/null 2>&1 && {
        echo -e "${_color_bold}${repo}${_color_off}"
        git -c color.branch=always -C "$repo" branch -vvv | grep '\ ahead\ '
        echo
    }
done < <(ghq list --full-path)
