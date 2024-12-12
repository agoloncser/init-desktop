#!/usr/bin/env bash

set -eu

EXPIRE_DAYS=7

_help() {
    cat << EOF
Usage: ${0##*/} [-d DAYS]

Options:
  -d DAYS    Set the number of days for the expiration threshold (default is $EXPIRE_DAYS days)
  -h         Show this help message and exit
EOF
}

while getopts ":d:h" options; do
    case $options in
        d) EXPIRE_DAYS=$OPTARG ;; # days
        h) _help; exit 0 ;;
        *) _help; exit 1 ;;
    esac
done

future=
# Check if date command supports -v (macOS/BSD)
if date -v "+${EXPIRE_DAYS}d" > /dev/null 2>&1; then
    future=$(date -v "+${EXPIRE_DAYS}d" +"%FT%T")
# Otherwise, use GNU date format (Linux)
elif date --date="+${EXPIRE_DAYS} days" > /dev/null 2>&1; then
    future=$(date --date="+${EXPIRE_DAYS} days" +"%FT%T")
else
    echo "Unsupported platform"
    exit 1
fi

_verify(){
    cert_valid="$(ssh-keygen -Lf "$cert_name" | grep 'Valid:' | awk '{print $5}')"
    now="$(date +%FT%T)"
    if [[ "$cert_valid" < "$now" ]] ; then
        echo "WARNING cert expired: $cert_valid - $cert_name"
    elif [[ "$cert_valid" < "$future" ]] ; then
        echo "WARNING cert expiring soon: $cert_valid - $cert_name"
    fi
}

find "${HOME}/.ssh" "/etc/ssh" -type f -name "*-cert.pub" |\
    while read -r cert_name ; do
        _verify
    done
