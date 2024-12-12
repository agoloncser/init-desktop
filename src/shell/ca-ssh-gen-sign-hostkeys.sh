#!/usr/bin/env bash

set -eu

# options
FORCE_OVERWRITE=""
HOST_CERT_VALID="+1w"
NAME=""
OUTDIR=""
VAULT_PASSWORD_FILE=""
while getopts Fn:o:p:V:S:C: options
do
    case $options in
        n) NAME=$OPTARG;;
        S) CA_SSH_SCENARIO=$OPTARG;;
        C) CA_PRIVKEY_DIR=$OPTARG;;
        F) FORCE_OVERWRITE=1 ;;
        o) OUTDIR=$OPTARG ;;
        p) VAULT_PASSWORD_FILE=$OPTARG ;;
        V) HOST_CERT_VALID=$OPTARG ;;
        *) exit 1 ;;
    esac
done

# check mandatory options
if [ -z "$NAME" ] ; then
    echo "Option -n is mandatory"
    exit 1
fi
if [ -z "$OUTDIR" ] ; then
    echo "Option -o is mandatory"
    exit 1
fi

# env vars
CA_SSH_FORCE_OVERWRITE_HOSTKEYS=${CA_SSH_FORCE_OVERWRITE_HOSTKEYS:=""}
if [ -n "$CA_SSH_FORCE_OVERWRITE_HOSTKEYS" ] ; then
    FORCE_OVERWRITE=1
fi

# setup work files and directories
_workdir="$(mktemp -d)"
_name_sanitized="$(echo "$NAME" | sed 's/\./-/g')"
_file_src_ssh_hostkey_private="${_workdir}/ed25519-${_name_sanitized}"
_file_src_ssh_hostkey_public="${_file_src_ssh_hostkey_private}.pub"
_file_src_ssh_hostkey_cert="${_file_src_ssh_hostkey_private}-cert.pub"

# setup final files and directories
_directory_dst="${OUTDIR}/${NAME}/ssh_hostkey/"
_file_dst_ssh_hostkey_private="${_directory_dst}/ssh_hostkey_private"
_file_dst_ssh_hostkey_public="${_directory_dst}/ssh_hostkey_public"
_file_dst_ssh_hostkey_cert="${_directory_dst}/ssh_hostkey_cert"

# check for existing files
for i in "$_file_dst_ssh_hostkey_private" "$_file_dst_ssh_hostkey_private" "$_file_dst_ssh_hostkey_public" ; do
    if [ -e "$i" ] && [ -z "$FORCE_OVERWRITE" ] ; then
        echo "$i exits, use -F to overwrite files"
        exit 1
    else
        # prepare outdir
        _outdir="$(dirname "$i")"
        if [ ! -d "$_outdir" ] ; then
            mkdir -p "$_outdir"
        fi
    fi
done

# generate new keypair
ssh-keygen -t ed25519 -C "host key $NAME created: $(date +%Y%m%d-%H%M%S)" -f "$_file_src_ssh_hostkey_private" -P ""

# vault the private part
if [ -n "$VAULT_PASSWORD_FILE" ] ; then
    ansible-vault encrypt --vault-password-file="$VAULT_PASSWORD_FILE" "$_file_src_ssh_hostkey_private"
else
    ansible-vault encrypt "$_file_src_ssh_hostkey_private"
fi

# sign hostkey for certificate
echo "Waiting for GPG..."
_passdir="ca-ssh/${CA_SSH_SCENARIO}/ed25519-${CA_SSH_SCENARIO}"
_ca_privkey_path="${CA_PRIVKEY_DIR}/${CA_SSH_SCENARIO}/ed25519-${CA_SSH_SCENARIO}"
ssh-keygen -P "$(pass "${_passdir}/passphrase")" -s "$_ca_privkey_path" -I "$NAME" -h -n "$NAME" -V "$HOST_CERT_VALID" "$_file_src_ssh_hostkey_public"

# move work files to the final place
mv "$_file_src_ssh_hostkey_private" "$_file_dst_ssh_hostkey_private"
mv "$_file_src_ssh_hostkey_public"  "$_file_dst_ssh_hostkey_public"
mv "$_file_src_ssh_hostkey_cert"    "$_file_dst_ssh_hostkey_cert"

# remove workdir
rm -rf "$_workdir"
