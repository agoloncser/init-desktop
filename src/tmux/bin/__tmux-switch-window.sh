#!/usr/bin/env bash

#
# Use fzf to switch between tmux windows and sessions.
#

if [ -z "$TMUX" ] ; then
    echo "ERROR: This script must be run inside tmux."
    exit 1
fi

target_pane=$(tmux lsw -aF "#{window_activity} #{session_name}:#{window_index} #{window_name} #{pane_title}" |\
                  grep -v choose-tree-fzf |\
                  # sort by timestamp provided 'window_activity'
                  sort -rn |\
                  # remove timestamp
                  cut -d " " -f2- |\
                  fzf --reverse --preview="tmux capture-pane -ep -t {1}" --preview-window down,follow |\
                  # get only the target pane id
                  cut -d " " -f1)

if [ -n "$target_pane" ] ; then
    tmux switch-client -t "$target_pane"
fi
