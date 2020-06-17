#!/bin/sh
set -o errexit
set -xv
cat Dockerfile_${FROM_DISTRO}.template | envsubst > Dockerfile
docker build --tag travis .
