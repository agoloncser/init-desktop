#!/bin/sh

set -xv

while getopts l:k: options
do
    case $options in
        k) key_usage=$OPTARG ;;
        l) passphrase_length=$OPTARG ;;
        *) echo "Invalid options" ; exit 1
    esac
done

_help(){
cat <<EOF

-l INT .... passphrase length (e.g. '64')
-k NAME ... name the usage  (e.g. 'github')

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

MY_HOSTNAME=$(hostname | perl -F'\.' -lane 'print $F[0]')

KEYNAME="ed25519-${key_usage}-${MY_HOSTNAME}-${USER}"
PASSPHRASE_LOCATION="ssh/${KEYNAME}/passphrase"
PUBKEY_LOCATION="ssh/${KEYNAME}/pubkey"

pass generate --no-symbols "${PASSPHRASE_LOCATION}" "$passphrase_length"
mkdir -p "$HOME/.ssh" || true
chmod 0700 "$HOME/.ssh"
ssh-keygen -t ed25519 -C "[${KEYNAME}-$(date +%Y%m%d-%H%M%S)]" -f "$HOME/.ssh/${KEYNAME}" -P "$(pass "${PASSPHRASE_LOCATION}")"
cat "$HOME/.ssh/${KEYNAME}.pub" | pass insert -m "$PUBKEY_LOCATION"
cat "$HOME/.ssh/${KEYNAME}.pub"
