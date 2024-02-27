# Desktop init scripts

This code installs some basic tools and make some initial configuration to my
desktop systems.

Supports:

- macOS
- Ubuntu 20.04, 22.04
- Fedora 38-40
- FreeBSD

## Prerequisites

On Darwin the following command must run to bootstrap the installation:

```shell
xcode-select --install
```

## Install

To install the environment run the following:

```shell
git clone https://github.com/agl4/init-desktop
cd init-desktop
make install
```

By default this upgrades the whole system before installing anything. To skip
this step, set the variable `INSTALL_FAST` before running the install
scripts. This will also skip compiling everything from source with `asdf`.

```shell
INSTALL_FAST=1 make install
```
