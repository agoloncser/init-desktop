#!/bin/sh

set -euxv

GNUPGHOME=${GNUPGHOME:="${HOME}/.gnupg"}

mkdir "$GNUPGHOME" 2>/dev/null || true
chmod 0700 "$GNUPGHOME"

cat <<EOF > "${GNUPGHOME}/gpg.conf"
personal-cipher-preferences AES256 AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
charset utf-8
fixed-list-mode
no-comments
no-emit-version
keyid-format 0xlong
list-options show-uid-validity
verify-options show-uid-validity
with-fingerprint
require-cross-certification
no-symkey-cache
use-agent
EOF

cat <<EOF > "${GNUPGHOME}/gpg-agent.conf"
enable-ssh-support
default-cache-ttl 10
max-cache-ttl 10
#pinentry-program /usr/bin/pinentry-curses
max-cache-ttl-ssh 10
EOF

cat <<EOF > "${GNUPGHOME}/scdaemon.conf"
#log-file /home/agl/scdaemon.log
#debug-all
card-timeout 30
reader-port Yubico YubiKey
disable-ccid
EOF
