# Desktop init scripts

On Darwin the following command must run to bootstrap the installation:

```shell
xcode-select --install
```

## Environment

By default the below scripts upgrade the nodes as well. However there are circumstances that this is not required. In this cases use the following environment variable:

```shell
export DESKTOP_INIT_SKIP_UPGRADE=1
```

or when using `fish` shell:

```shell
set -xg DESKTOP_INIT_SKIP_UPGRADE 1
```

## Setup OS

Ubuntu

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_ubuntu.sh | sh -xv
```

macOS

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_darwin.sh | sh -xv
```

Fedora

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_fedora.sh | sh -xv
```

## Caps-lock to control on Gnome

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/99_caps.sh | sh -xv
```

## Setup GnuPG

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/01_gpg.sh | sh -xv
```

## Trust Github ssh hostkeys

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/readme/src/03_trust_github.sh | sh -xv
```

## Generate host ssh key

```shell
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/02_genssh.sh | sh -xv
```
