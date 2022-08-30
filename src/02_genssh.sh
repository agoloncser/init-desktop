#!/bin/sh

set -eu
set -xv

while getopts k:l: options
do
    case $options in
        k) key_usage=$OPTARG ;;
        l) passphrase_lenght=$OPTARG ;;
        *) echo "Invalid options" ; exit 1
    esac
done

if [ -z "$key_usage" ] ; then
    echo "Key usage must be set (mmegh|github|work)."
    exit 1
fi
if [ -z "$passphrase_lenght" ] ; then
    echo "Passphrase lenght must be set (integer)."
    exit 1
fi

MY_HOSTNAME=$(hostname | perl -F'\.' -lane 'print $F[0]')

KEYNAME="ed25519-${key_usage}-${MY_HOSTNAME}-${USER}"
PASSPHRASE_LOCATION="ssh/${KEYNAME}/passphrase"
PUBKEY_LOCATION="ssh/${KEYNAME}/pubkey"


pass generate --no-symbols "${PASSPHRASE_LOCATION}" "$passphrase_lenght"
pass -c "${PASSPHRASE_LOCATION}"

mkdir -p "$HOME/.ssh" || true
chmod 0700 "$HOME/.ssh"
ssh-keygen -t ed25519 -C "[$KEYNAME $(date +%Y%m%d)]" -f "$HOME/.ssh/${KEYNAME}"
cat "$HOME/.ssh/${KEYNAME}.pub" | pass insert -m "$PUBKEY_LOCATION"
cat "$HOME/.ssh/${KEYNAME}.pub"
