#!/usr/bin/env bash

set -eu

export DISPLAY=""

KEY_TO_SIGN=""
CA_PATH_IN_PASS="ca-ssh"
CERT_VALID="+8h"
CA_PUBKEY_PATH=""
CA_NAME=""

CERT_IDENTITY_DEFAULT="${USER}@${HOSTNAME}"
CERT_EXTENSIONS_DEFAULT="no-x11-forwarding"
CERT_PRINCIPALS_DEFAULT="root,${USER}"

_help(){
    cat <<EOF
$0 - Usage:

   $0 <options>

Options

-C NAME ........ CA name
-f PUBKEY ...... path to public key to sign
-V TIME ........ set the certificate validity (optional, default $CERT_VALID)
-P PATH ........ set the CA public key file, useful when CA is already added to agent
                 before signing

EOF

    exit 1
}

while getopts C:V:f:P: options
do
    case $options in
        C) CA_NAME=$OPTARG ;;
        f) KEY_TO_SIGN=$OPTARG ;;
        V) CERT_VALID=$OPTARG ;;
        P) CA_PUBKEY_PATH=$OPTARG ;;
        *) _help ;;
    esac
done

if [ -z "$KEY_TO_SIGN" ] ; then
    echo "ERROR: Missing option -f <KEY_TO_SIGN>"
    _help
fi



_sign_with_ca(){
    if [ -z "$CA_PUBKEY_PATH" ] ; then
        if [ -z "$CA_NAME" ] ; then
            echo "ERROR: CA_NAME must be defined."
            _help
        fi
        _ca_pubkey_path=$(mktemp)
        ca-ssh-add-key-to-agent-from-pass.sh \
            -t 10 \
            -p "${CA_PATH_IN_PASS}/${CA_NAME}" \
            -f "$_ca_pubkey_path"
    else
        _ca_pubkey_path="$CA_PUBKEY_PATH"
    fi

    echo "Sign the public key..."
    ssh-keygen \
        -Us "$_ca_pubkey_path" \
        -I "$CERT_IDENTITY" \
        -n "$CERT_PRINCIPALS" \
        -V "$CERT_VALID" \
        "${CERT_EXTENSIONS_OPTIONS[@]}" \
        "${KEY_TO_SIGN}.pub"

    if [ -z "$CA_PUBKEY_PATH" ] ; then
        ca-ssh-add-key-to-agent-from-pass.sh \
            -R "$_ca_pubkey_path"
        rm "$_ca_pubkey_path"
    fi

    echo
    echo "Show cert information..."
    ssh-keygen -Lf "${KEY_TO_SIGN}-cert.pub"
}

_request_file="${KEY_TO_SIGN}.req"

if [ -e "$_request_file" ] ; then
    # shellcheck source=share/samples/ca-ssh-sign-user-pubkey-with-pass/sample.req
    source "$_request_file"
fi

CA_NAME=${CA_NAME:=""} # this is required
CERT_PRINCIPALS=${CERT_PRINCIPALS:="$CERT_PRINCIPALS_DEFAULT"}
CERT_EXTENSIONS=${CERT_EXTENSIONS:="$CERT_EXTENSIONS_DEFAULT"}
CERT_IDENTITY=${CERT_IDENTITY:="$CERT_IDENTITY_DEFAULT"}
CERT_EXTENSIONS_OPTIONS=( )
for ext  in $(echo "$CERT_EXTENSIONS" | tr "," "\n") ; do
    CERT_EXTENSIONS_OPTIONS+=( "-O" "$ext" )
done

_sign_with_ca
