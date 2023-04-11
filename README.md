---
author: ["Attila Gölöncsér"]
draft: false
---

## Desktop init scripts {#desktop-init-scripts}


### Setup OS {#setup-os}


#### Setup Ubuntu {#setup-ubuntu}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_ubuntu.sh | sh -xv
```


#### Setup macOS {#setup-macos}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_mac.sh | sh -xv
```


#### Setup Fedora {#setup-fedora}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/00_fedora.sh | sh -xv
```


### Misc init scripts {#misc-init-scripts}


#### Caps-lock to control on Gnome {#caps-lock-to-control-on-gnome}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/99_caps.sh | sh -xv
```


#### Generate host ssh key {#generate-host-ssh-key}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/02_genssh.sh | sh -xv
```


#### Setup GnuPG {#setup-gnupg}

```text
curl -fsSL https://raw.githubusercontent.com/agoloncser/desktop-init-scripts/master/src/01_gpg.sh | sh -xv
```
