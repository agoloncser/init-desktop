#!/bin/sh

set -eu
set -xv

gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps']"

