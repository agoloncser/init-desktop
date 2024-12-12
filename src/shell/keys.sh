#!/usr/bin/env bash
#
# Adds ssh key to agent
#
# Wrapper script over more complicated key management tools.
#

set -eu

name="$*"

if [ -z "$name" ] ; then
    ssh-add -l
    exit 0
fi

file_ssh_key_prefix="${HOME}/.ssh"
current_path="$(dirname "$0")"
cert_name="${file_ssh_key_prefix}/${name}-cert.pub"

if [ "$(basename $0)" = "keys_week" ] ; then
    # 7 days in seconds
    _timeout=604800
else
    _timeout=28800
fi

_add(){
    "${current_path}/add-ssh-key-to-agent-with-passphrase.py" \
        -p "ssh/${name}/passphrase" \
        -t "$_timeout" \
        -k "${file_ssh_key_prefix}/${name}"
}

_show_sign_error(){
cat <<EOF
Key certificate expired, not adding.

You can sign it with the below command:

ca-ssh-sign-user-pubkey-with-pass.sh -f ${file_ssh_key_prefix}/${name}

EOF
exit 1
}

if [ -f "$cert_name" ] ; then
    pubkey_valid=$(ssh-keygen -Lf "$cert_name" | grep 'Valid:' | awk '{print $5}')
    now="$(date +%Y-%m-%dT%H:%M:%S)"
    if [[ "$pubkey_valid" < "$now" ]] ; then
        _show_sign_error
    else
        _add
    fi
else
    _add
fi

