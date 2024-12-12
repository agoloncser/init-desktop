#!/bin/bash

set -eu

# shellcheck source=share/samples/ca-ssh-sign-user-pubkey/vars
source ./vars
# shellcheck source=share/samples/ca-ssh-sign-user-pubkey/user-vars
source ./user-vars

_help(){
    cat <<EOF
$0 - Usage:

Sign the user key stored in '-p <PATH_TO_PUBLIC_KEY_IN_PASS>' with the certificate $KEYNAME

EOF

    exit 1
}

PUBLIC_KEY_PATH_IN_PASS=""
while getopts p: options
do
    case $options in
        p) PUBLIC_KEY_PATH_IN_PASS=$OPTARG ;;
        *) _help ;;
    esac
done

if [ -z "$PUBLIC_KEY_PATH_IN_PASS" ] ; then
    echo "Option -p is mandatory"
    echo
    _help
fi

_file_tmp_pubkey=$(mktemp)
_file_tmp_pubkey_cert="${_file_tmp_pubkey}-cert.pub"


echo "Touch the device to get the public key..."
pass "${PUBLIC_KEY_PATH_IN_PASS}/pubkey" > "$_file_tmp_pubkey"

echo "Touch the device to get the User CA passphrase..."
ssh-keygen -P "$(pass "${PASSDIR}/passphrase")" -s "$KEYNAME" -I "$USER_IDENTITY" -n root -V "$USER_CERT_VALID" -O no-x11-forwarding "$_file_tmp_pubkey"
pass insert -m "${PUBLIC_KEY_PATH_IN_PASS}/cert" < "$_file_tmp_pubkey_cert"
rm "$_file_tmp_pubkey" "$_file_tmp_pubkey_cert"

echo
pass "$PUBLIC_KEY_PATH_IN_PASS"
