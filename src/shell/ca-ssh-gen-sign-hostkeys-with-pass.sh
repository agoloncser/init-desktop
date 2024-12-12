#!/usr/bin/env bash

set -eu

# options
CA_SSH_FORCE_OVERWRITE_HOSTKEYS=""
FORCE_OVERWRITE=""
CERT_VALID="+1w"
HOST_IDENTITY=""
OUTDIR=""
CA_PUBKEY_PATH=""
while getopts n:FI:o:V:P: options
do
    case $options in
        I) HOST_IDENTITY=$OPTARG ;;
        n) CERT_PRINCIPALS=$OPTARG ;;
        P) CA_PUBKEY_PATH=$OPTARG ;;
        F) FORCE_OVERWRITE=1 ;;
        o) OUTDIR=$OPTARG ;;
        V) CERT_VALID=$OPTARG ;;
        *) exit 1 ;;
    esac
done

# check mandatory options
if [ -z "$HOST_IDENTITY" ] ; then
    echo "Option -n is mandatory"
    exit 1
fi
if [ -z "$OUTDIR" ] ; then
    echo "Option -o is mandatory"
    exit 1
fi
if [ -z "$CA_PUBKEY_PATH" ] ; then
    echo "Option -P is mandatory"
    exit 1
fi

# optional
CERT_PRINCIPALS=${CERT_PRINCIPALS:="$HOST_IDENTITY"}

# env vars
if [ -n "$CA_SSH_FORCE_OVERWRITE_HOSTKEYS" ] ; then
    FORCE_OVERWRITE=1
fi

# setup work files and directories
_workdir="$(mktemp -d)"
_file_src_ssh_hostkey_private="${_workdir}/ed25519-private"
_file_src_ssh_hostkey_public="${_file_src_ssh_hostkey_private}.pub"
_file_src_ssh_hostkey_cert="${_file_src_ssh_hostkey_private}-cert.pub"

# setup final files and directories
_directory_dst="${OUTDIR}/${HOST_IDENTITY}/ssh_hostkey/"
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
ssh-keygen -t ed25519 -C "host key $HOST_IDENTITY created: $(date +%Y%m%d-%H%M%S)" -f "$_file_src_ssh_hostkey_private" -P ""

# vault the private part
ansible-vault encrypt "$_file_src_ssh_hostkey_private"

echo "Sign the public key..."
ssh-keygen -Us "$CA_PUBKEY_PATH" -I "$HOST_IDENTITY" -h -n "$CERT_PRINCIPALS" -V "$CERT_VALID" "$_file_src_ssh_hostkey_public"

# move work files to the final place
mv "$_file_src_ssh_hostkey_private" "$_file_dst_ssh_hostkey_private"
mv "$_file_src_ssh_hostkey_public"  "$_file_dst_ssh_hostkey_public"
mv "$_file_src_ssh_hostkey_cert"    "$_file_dst_ssh_hostkey_cert"

# remove workdir
rm -rf "$_workdir"
