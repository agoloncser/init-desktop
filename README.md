# Desktop init scripts

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

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_ubuntu.sh | sh -xv
```

macOS

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_mac.sh | sh -xv
```

Fedora

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_fedora.sh | sh -xv
```

## Caps-lock to control on Gnome

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/99_caps.sh | sh -xv
```

## Setup GnuPG

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/01_gpg.sh | sh -xv
```

## Trust Github ssh hostkeys

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/readme/src/03_trust_github.sh | sh -xv
```

## Generate host ssh key

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/02_genssh.sh | sh -xv
```
