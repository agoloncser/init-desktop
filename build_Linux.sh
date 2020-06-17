#!/bin/sh
set -o errexit
set -xv

cat Dockerfile_${FROM_DISTRO}.template | envsubst > Dockerfile
docker build . --tag travis
docker ps -a
docker run -d --privileged --name travis -v /sys/fs/cgroup:/sys/fs/cgroup:ro travis
sleep 2
docker ps -a
docker exec --tty travis env TERM=vt100 id
docker exec --tty travis env TERM=vt100 cat ~/.bashrc
docker exec --tty travis env TERM=vt100 python --version
docker exec --tty travis env TERM=vt100 ansible --version
