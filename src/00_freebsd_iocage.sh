#!/bin/sh

set -xv
set -eu

export PATH="/usr/local/bin:$PATH"

#
# update the system
#
export PAGER=cat
freebsd-update fetch --not-running-from-cron

#
# packages
#
export ASSUME_ALWAYS_YES=YES
pkg update -f
pkg install -y mosh tmux fish python39 ca_root_nss fzf rsync starship curl jq

#
# sshd setup
#
sysrc sshd_enable="YES"
cat <<EOF > /etc/ssh/sshd_config
PermitRootLogin without-password
GatewayPorts no
X11Forwarding no
Subsystem       sftp    /usr/libexec/sftp-server
PasswordAuthentication no
PubkeyAuthentication yes
EOF

#
# ssh access to root
#
mkdir -p /root/.ssh
chmod 0700 /root/.ssh
curl -sSL https://api.github.com/users/agoloncser/keys | jq -r '.[] | .key' > /root/.ssh/authorized_keys

#
# misc rc setup
#
sysrc accounting_enable="NO"
sysrc fsck_y_enable="YES"
sysrc hostid_enable="YES"
sysrc ntpd_enable="YES"
sysrc ntpdate_enable="YES"
sysrc sshd_enable="YES"
sysrc clear_tmp_enable="YES"
sysrc sendmail_enable="NO"
sysrc sendmail_submit_enable="NO"
sysrc sendmail_outbound_enable="NO"
sysrc sendmail_msp_queue_enable="NO"

#
# misc loader setup
#
cat <<EOF >> /boot/loader.conf
# geom labelling support
kern.geom.label.disk_ident.enable=0
kern.geom.label.gptid.enable=0
kern.geom.label.gpt.enable=1
EOF

#
# iocage
#
echo 'fdesc /dev/fd fdescfs rw 0 0' >> /etc/fstab
pkg install -y py39-iocage
ln /usr/local/bin/python3.9 /usr/local/bin/python
sysrc zfs_enable="YES"
sysrc iocage_enable="YES"
echo 'zfs_load="YES"' >> /boot/loader.conf

#
# fish
#
if [ -x /usr/local/bin/fish ] ; then
    mkdir -p /root/.config/fish/completions || true
    mkdir -p /root/.config/fish/functions || true
    for i in functions/fisher.fish completions/fisher.fish ; do
        curl -sSL "https://raw.githubusercontent.com/jorgebucaran/fisher/HEAD/$i" -o "/root/.config/fish/$i"
    done
    fish -c 'fisher install jethrokuan/fzf'
    echo 'starship init fish | source' >> "/root/.config/fish/config.fish"
    /usr/bin/chsh -s /usr/local/bin/fish
fi
