#!/bin/sh

set -eu

NO_HOSTNAME=""
NO_USERNAME=""
key_usage=""
passphrase_length="64"
NO_PASSPHRASE=""
NO_PUBKEY_IN_PASS=""
while getopts NPl:k:d:HUB: options
do
    case $options in
        k) key_usage=$OPTARG ;;
        l) passphrase_length=$OPTARG ;;
        d) key_directory=$OPTARG ;;
        H) NO_HOSTNAME=1 ;;
        U) NO_USERNAME=1 ;;
        B) PASS_BASE_DIRECTORY=$OPTARG ;;
        P) NO_PASSPHRASE=1 ;;
        N) NO_PUBKEY_IN_PASS=1 ;;
        *) echo "Invalid options" ; exit 1
    esac
done

_help(){
cat <<EOF

-l INT .... passphrase length (default: '64')
-k NAME ... name the usage  (e.g. 'github')
-d DIR .... directory to save the key (optional, default; '$HOME/.ssh')
-H ........ do not add current hostname to key name (optional)
-U ........ do not add current username to key name (optional)
-B ........ set base directory in pass where to store the pubkey (optional)
-P ........ do not create a key passphrase in pass but request interactively (optional)
-N ........ do not save pubkey into pass (optional)

Only ED25519 keys are supported.

Example for host-based key generation, store private key only locally.

    $0 -l 64 -k github

EOF
exit 1
}

if [ -z "$key_usage" ] ; then
    _help
fi
if [ -z "$passphrase_length" ] && [ -z "$NO_PASSPHRASE" ] ; then
    _help
fi

set -eu

PASS_BASE_DIRECTORY=${PASS_BASE_DIRECTORY:="ssh"}
KEYNAME="ed25519-${key_usage}"
KEY_COMMENT="name:${key_usage} created:$(date +%Y%m%d-%H%M%S)"
if [ -z "$NO_HOSTNAME" ] ; then
    MY_HOSTNAME=$(hostname | perl -F'\.' -lane 'print $F[0]')
    KEYNAME="${KEYNAME}-${MY_HOSTNAME}"
    KEY_COMMENT="name:${key_usage} created:$(date +%Y%m%d-%H%M%S) host:${MY_HOSTNAME}"
fi
if [ -z "$NO_USERNAME" ] ; then
    KEYNAME="${KEYNAME}-${USER}"
fi

PASSPHRASE_LOCATION="${PASS_BASE_DIRECTORY}/${KEYNAME}/passphrase"
PUBKEY_LOCATION="${PASS_BASE_DIRECTORY}/${KEYNAME}/pubkey"

# this is optional so we can give a default
key_directory=${key_directory:="${HOME}/.ssh/"}

if [ -z "$NO_PASSPHRASE" ] ; then
    pass generate --no-symbols "${PASSPHRASE_LOCATION}" "$passphrase_length"
fi 
mkdir -p "$key_directory" || true
chmod 0700 "$key_directory"
if [ -z "$NO_PASSPHRASE" ] ; then
    echo 'Touch the device...'
    ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "${key_directory}/${KEYNAME}" -P "$(pass "${PASSPHRASE_LOCATION}")"
else
    ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "${key_directory}/${KEYNAME}"
fi

if [ -z "$NO_PUBKEY_IN_PASS" ] ; then
    pass insert -m "$PUBKEY_LOCATION" < "${key_directory}/${KEYNAME}.pub"
fi

echo
cat "${key_directory}/${KEYNAME}.pub"
