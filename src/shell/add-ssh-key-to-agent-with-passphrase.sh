#!/usr/bin/env bash

#
# Adds ssh key to the agent with key passphrase stored in pass.
#

set -eu

# defaults
opt_lifetime="7200"

while getopts k:p:t: options
do
    case $options in
        p) opt_pass=$OPTARG ;;
        k) opt_key=$OPTARG ;;
        t) opt_lifetime=$OPTARG ;;
        *) exit 1;;
    esac
done

function _help(){
    cat <<EOF

$0 - add key from password store to ssh-agent

Options:

  -p NAME   Where to find the ssh passphrase in pass eg. ssh/key/passphrase
  -k PATH   Path to ssh key to add on disk eg. ~/.ssh/id_rsa
  -t SEC    Set key lifetime in seconds (Default: $opt_lifetime)

EOF
    exit 1
}

# checks
if [ -z "$opt_pass" ] ; then
    echo "option -p is mandatory"
    _help
fi
if [ -z "$opt_key" ] ; then
    echo "option -k is mandatory"
    _help
fi
if [ ! -f "$opt_key" ] ; then
    echo "$opt_key is not a file or does not exists."
    exit 1
fi

# 1. **`export DISPLAY="dummy"`**:
#    - `DISPLAY` is an environment variable used by X11, the window system
#      commonly used on Unix-like operating systems. `ssh-add` uses `SSH_ASKPASS`
#      to prompt for passwords in a graphical environment. However, if there is no
#      active display (like when running in a headless or non-graphical
#      environment), setting `DISPLAY` to `"dummy"` tricks the system into
#      thinking there's a display available, allowing `SSH_ASKPASS` to be used
#      without a graphical interface.

# 2. **`SSH_ASKPASS=$(mktemp)`**:
#    - `SSH_ASKPASS` is an environment variable that points to a program or script
#      used by `ssh-add` to fetch the passphrase. In this script, `$(mktemp)`
#      creates a temporary file, which will be used to store a small script that
#      outputs the passphrase. This ensures that the passphrase is provided
#      automatically to `ssh-add` without user interaction.

# 3. **`export SSH_ASKPASS`**:
#    - This command makes the `SSH_ASKPASS` variable available to any subprocesses
#      spawned by the script. Since `ssh-add` is executed as a subprocess, it
#      needs to know where to find the `SSH_ASKPASS` script. By exporting this
#      variable, the main script ensures that the temporary script created by
#      `mktemp` is used by `ssh-add` to read the passphrase from the `pass` store.

# These steps collectively enable the script to add the SSH key to the agent
# securely and automatically, without requiring manual input of the
# passphrase.
export DISPLAY="dummy"
SSH_ASKPASS=$(mktemp)
export SSH_ASKPASS

_cleanup()
{
  rm "$SSH_ASKPASS"
}
trap _cleanup 1 2 3 6

# This is the main gotcha, SSH_ASKPASS must be a program that reads the
# passphrase.
cat <<EOF > "${SSH_ASKPASS}"
#!/bin/sh
pass $opt_pass | head -1
EOF
chmod +x "${SSH_ASKPASS}"

echo Adding key "$opt_key"
echo "Waiting for GPG..."
ssh-add -t "$opt_lifetime" "$opt_key" < /dev/null
_cleanup
