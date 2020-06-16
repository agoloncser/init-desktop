#!/bin/sh
set -o errexit
set -xv
flag_n=
while getopts n options
do
    case $options in
        n) flag_n=1 ;;
    esac
done

# installing homebrew
if [ ! -x /usr/local/bin/brew ] ; then
    yes|/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo Already installed
fi
set -xv
brew update
if [ -z "$flag_n" ] ; then
    brew upgrade
fi
brew install git
