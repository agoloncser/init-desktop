# Desktop init scripts

This repo installs some basic tools and make some initial configuration to my desktop system.

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
git clone https://github.com/agoloncser/desktop-init-scripts
cd desktop-init-scripts
make install
```

By default this upgrades the whole system before installing anything. To skip this step, set the variable `INSTALL_FAST` before running the install scripts. This will also skip compiling everything from source with `asdf`.

```shell
INSTALL_FAST=1 make install
```
