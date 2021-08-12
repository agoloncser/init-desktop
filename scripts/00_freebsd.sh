#!/bin/sh
pkg update
pkg install -y git curl python38 py38-ansible gnupg password-store tmux openssh-portable py38-pipenv

# gnome
pkg install -y gnome3-lite xorg
cat <<EOF >> /etc/fstab
proc           /proc       procfs  rw  0   0
EOF
sysctl dbus_enable="YES"
sysctl gdm_enable="YES"
sysctl gnome_enable="YES"
