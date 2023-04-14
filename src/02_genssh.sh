#!/bin/sh

set -eu

flag_H=""
flag_U=""
key_usage=""
passphrase_length="64"
while getopts l:k:d:HUB:C: options
do
    case $options in
        k) key_usage=$OPTARG ;;
        l) passphrase_length=$OPTARG ;;
        d) key_directory=$OPTARG ;;
        H) flag_H=1 ;;
        U) flag_U=1 ;;
        B) PASS_BASE_DIRECTORY=$OPTARG ;;
        C) CA_NAME=$OPTARG ;;
        *) echo "Invalid options" ; exit 1
    esac
done

_help(){
cat <<EOF

-l INT .... passphrase length (e.g. '64')
-k NAME ... name the usage  (e.g. 'github')
-d DIR .... directory to save the key (optional, default; '$HOME/.ssh')
-C CA ..... name of the CA to use (optional)

Only ED25519 keys are supported.

Example for host-based key generation, store private key only locally.

    $0 -l 64 -k github

EOF
exit 1
}

if [ -z "$key_usage" ] ; then
    _help
fi
if [ -z "$passphrase_length" ] ; then
    _help
fi

set -eu

PASS_BASE_DIRECTORY=${PASS_BASE_DIRECTORY:="ssh"}
KEYNAME="ed25519-${key_usage}"
if [ -z "$flag_H" ] ; then
    MY_HOSTNAME=$(hostname | perl -F'\.' -lane 'print $F[0]')
    KEYNAME="${KEYNAME}-${MY_HOSTNAME}"
fi
if [ -z "$flag_U" ] ; then
    KEYNAME="${KEYNAME}-${USER}"
fi

PASSPHRASE_LOCATION="${PASS_BASE_DIRECTORY}/${KEYNAME}/passphrase"
PUBKEY_LOCATION="${PASS_BASE_DIRECTORY}/${KEYNAME}/pubkey"

KEY_COMMENT="name:${key_usage} created:$(date +%Y%m%d-%H%M%S)"
if [ -n "$CA_NAME" ] ; then
    KEY_COMMENT="name:${key_usage} created:$(date +%Y%m%d-%H%M%S) ca:$CA_NAME"
fi

# this is optional so we can give a default
key_directory=${key_directory:="${HOME}/.ssh/"}

pass generate --no-symbols "${PASSPHRASE_LOCATION}" "$passphrase_length"
mkdir -p "$key_directory" || true
chmod 0700 "$key_directory"
echo 'Touch the device...'
ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "${key_directory}/${KEYNAME}" -P "$(pass "${PASSPHRASE_LOCATION}")"
pass insert -m "$PUBKEY_LOCATION" < "${key_directory}/${KEYNAME}.pub"

echo
cat "${key_directory}/${KEYNAME}.pub"
