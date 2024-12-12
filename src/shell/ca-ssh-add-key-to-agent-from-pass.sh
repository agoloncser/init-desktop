#!/usr/bin/env bash

set -eu

PATH_IN_PASS=""
DISPLAY=""
KEY_IN_AGENT_TIMEOUT=30
PUBKEY_TO_REMOVE=""

_help(){
    cat <<EOF
$0 - Usage:

   $0 <options>

Options

-p PATH ........ path to the keys in path (eg. "ca-ss/test-user-ca")
-f PUBKEY ...... path to public key export
-t SECONDS ..... set the lifetime of the private key in the agent (default: $KEY_IN_AGENT_TIMEOUT)
-R PATH ........ remove the public key at PATH from the agent

EOF
    exit 1

}

while getopts p:t:f:R: options
do
    case $options in
        p) PATH_IN_PASS=$OPTARG ;;
        t) KEY_IN_AGENT_TIMEOUT=$OPTARG ;;
        f) CA_PUBKEY_PATH=$OPTARG ;;
        R) PUBKEY_TO_REMOVE=$OPTARG ;;
        *) _help ;;
    esac
done

if [ -z "$PUBKEY_TO_REMOVE" ] && [ -z "$PATH_IN_PASS" ] ; then
    echo "ERROR: either -p or -R option is mandatory."
    _help
fi
if [ -n "$PUBKEY_TO_REMOVE" ] && [ -n "$PATH_IN_PASS" ] ; then
    echo "ERROR: -p and -R options are mutually exclusive."
    _help
fi

_cleanup()
{
  rm "$_ca_pubkey_path"
}
trap _cleanup 1 2 3 6

if [ -z "$PUBKEY_TO_REMOVE" ] ; then
    echo "Adding key ${PATH_IN_PASS} ..."
    _ca_pubkey_path=${CA_PUBKEY_PATH:="$(mktemp)"}
    echo "Get public key of the CA..."
    echo "Waiting for GPG..."
    pass "${PATH_IN_PASS}/public" > "$_ca_pubkey_path"
    echo "Adding CA to ssh-agent..."
    echo "Waiting for GPG..."
    pass "${PATH_IN_PASS}/private" | ssh-add -t "$KEY_IN_AGENT_TIMEOUT" -
else
    echo "Removing key ${PUBKEY_TO_REMOVE} ..."
    ssh-add -d - < "$PUBKEY_TO_REMOVE"
fi
