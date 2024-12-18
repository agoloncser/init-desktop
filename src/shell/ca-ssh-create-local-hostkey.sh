#!/usr/bin/env bash

set -eu

# This is required on linux or the password input to work
DISPLAY=""

# options
CA_NAME=""
FORCE_OVERWRITE=""
CERT_VALID="-1m:+52w"
CA_PATH_IN_PASS="ca-ssh"
DOMAIN_LIST="cs.mmegh.local be.mmegh.local me.mmegh.local mmegh.local tail6efd3.ts.net"
CA_PUBKEY_PATH="$(mktemp)"

_help(){

    cat <<EOF

$0 -C NAME [-V VALID -F]

Generate local ssh certificates for the sshd service.

Options:

-C NAME ...... Name of the CA stored in pass on path ${CA_PATH_IN_PASS}/NAME
-V VALID ..... Validity of the certificate (default: $CERT_VALID)
-F ........... Force overwrite old certificates

EOF
}

while getopts hFV:C: options
do
    case $options in
        C) CA_NAME=$OPTARG ;;
        F) FORCE_OVERWRITE=1 ;;
        V) CERT_VALID=$OPTARG ;;
        h) _help ; exit 1 ;;
        *) _help ; exit 1 ;;
    esac
done

# Mandatory options
if [ -z "$CA_NAME" ] ; then
    echo "Option -C is mandatory"
    exit 1
fi

# Variables
HOST_SANS_DOMAIN=$(hostname| cut -d '.' -f 1)
CERT_PRINCIPALS=( )
for domain in $DOMAIN_LIST ; do
    CERT_PRINCIPALS+=( "${HOST_SANS_DOMAIN}.${domain}" )
done

_cleanup()
{
  rm "$CA_PUBKEY_PATH"
}
trap _cleanup 1 2 3 6

# Use agent to request the user only once for the passphrase.  The timeout of
# the key is relatively short, so there is no removal procedure implemented.
ca-ssh-add-key-to-agent-from-pass.sh \
    -t 5 \
    -p "${CA_PATH_IN_PASS}/${CA_NAME}" \
    -f "$CA_PUBKEY_PATH"

# This loop seems to be a bit complicated, but the purpose is the following:
# - We do not generate host keys, we sign the keys already existing on the node.
# - We want to operate with the least privileges possible, so we just use sudo
#   only for placing the certificates into /etc/ssh
for _hostkey_pub in $(find /etc/ssh/ -type f -name "*.pub" | grep -v -- '-cert.pub$') ; do
    _hostkey_cert="$(echo "$_hostkey_pub" | sed 's/\.pub$/-cert.pub/')"

    if [ -z "$FORCE_OVERWRITE" ] ; then
        if [ -f "$_hostkey_cert" ] ; then
            echo "ERROR: Certificate already exists, not overwriting: $_hostkey_cert"
            ssh-keygen -Lf "$_hostkey_cert"
            continue
        fi
    fi

    _hostkey_pub_tmp=$(mktemp)
    cp $_hostkey_pub $_hostkey_pub_tmp
    ssh-keygen \
        -Us "$CA_PUBKEY_PATH" \
        -I "$HOST_SANS_DOMAIN" \
        -h \
        -n "$(IFS=, ; echo "${CERT_PRINCIPALS[*]}")"  \
        -V "$CERT_VALID" \
        "$_hostkey_pub_tmp"
    sudo cp -v "${_hostkey_pub_tmp}-cert.pub" "$_hostkey_cert"
    sudo chmod 0644 "$_hostkey_cert"
    rm "$_hostkey_pub_tmp"
done

# Reload sshd to force reloading of keys and certificates

if [ -e /etc/ssh/ssh_host_ed25519_key ] && [ -e /etc/ssh/ssh_host_ed25519_key-cert.pub ] ; then
    sudo bash <<EOF
mkdir -p /etc/ssh/conf.d || true
echo "HostKey /etc/ssh/ssh_host_ed25519_key" > /etc/ssh/conf.d/ca-ssh-hostkey.conf
echo "HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub" >> /etc/ssh/conf.d/ca-ssh-hostkey.conf
EOF
fi

sudo systemctl restart sshd
