# Changelog

## [0.12.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.11.0...v0.12.0) (2023-05-19)


### Features

* **genssh:** Remove support for adding CA name to pubkey ([a4253f8](https://www.github.com/agoloncser/desktop-init-scripts/commit/a4253f8a49060f7115ed934e2720680bd8c15328))

## [0.11.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.10.0...v0.11.0) (2023-05-17)


### Features

* Revert FreeBSD support ([9354958](https://www.github.com/agoloncser/desktop-init-scripts/commit/935495865f56730cb670d5d028b29b80dc19e32f))


### Bug Fixes

* Fix package list ([9fd73d9](https://www.github.com/agoloncser/desktop-init-scripts/commit/9fd73d96cc454b52011bcfe0aa2e19eb27f3b84e))
* **genssh:** Add NO_PASSPHRASE option, help and clarify variables ([3616e37](https://www.github.com/agoloncser/desktop-init-scripts/commit/3616e370e6c60be09d64e1c3a49ab5ecc09da0e8))
* **genssh:** Add NO_PUBKEY_IN_PASS ([36aa483](https://www.github.com/agoloncser/desktop-init-scripts/commit/36aa483caeb5abc55ed1d7ee3980ea32909dcf1c))
* Option to skip upgrade ([ca728f4](https://www.github.com/agoloncser/desktop-init-scripts/commit/ca728f43e5c6a9ab5ea35907e5ca9361b2a4333c))

## [0.10.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.9.1...v0.10.0) (2023-04-14)


### Features

* Add CA support in genkey ([7bd159a](https://www.github.com/agoloncser/desktop-init-scripts/commit/7bd159a3eed9098becdca9cdbcecf53617b87ba0))
* **genssh:** Add pubkey to pass, control pass location ([162b217](https://www.github.com/agoloncser/desktop-init-scripts/commit/162b217a73f90913bf4416959dac7cbab58635a9))
* **genssh:** Add support for directory and key customization ([4b4b924](https://www.github.com/agoloncser/desktop-init-scripts/commit/4b4b924086bef292314157de4060e37aad6087df))
* Makefile ([87b4aa9](https://www.github.com/agoloncser/desktop-init-scripts/commit/87b4aa9bedb31cf84015c160269e722b42e7cc03))
* Skip upgrade ([2eb7a40](https://www.github.com/agoloncser/desktop-init-scripts/commit/2eb7a404ac9fcc8e281588d98f35640d9cee0860))
* Trust github, add hostkeys ([de876ee](https://www.github.com/agoloncser/desktop-init-scripts/commit/de876ee062a404a3b0f280042b75f641252856d8))


### Bug Fixes

* Fix unbound variable issues ([024cdb3](https://www.github.com/agoloncser/desktop-init-scripts/commit/024cdb3afd449e185efdad92cf3b5e0ff72f96de))
* rename script to darwin ([32ac7bf](https://www.github.com/agoloncser/desktop-init-scripts/commit/32ac7bfcc98930befab8931ae710e0a2be6bdec1))
* Upgrade asdf version ([28dfa80](https://www.github.com/agoloncser/desktop-init-scripts/commit/28dfa80d52209c5a6482c504757bda50fce2f296))

### [0.9.1](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.9.0...v0.9.1) (2023-03-21)


### Bug Fixes

* Add gconf2 package to Ubuntu ([15500d2](https://www.github.com/agoloncser/desktop-init-scripts/commit/15500d25810d62e2e2a35a9755d6f08d4c6323cc))

## [0.9.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.8.0...v0.9.0) (2022-09-07)


### Features

* Add freebsd iocage setup script ([3bd7672](https://www.github.com/agoloncser/desktop-init-scripts/commit/3bd7672efee8cf5bb7cc3503c61db16fcf35600d))


### Bug Fixes

* Add cmdwatch ([824373e](https://www.github.com/agoloncser/desktop-init-scripts/commit/824373e70f077bc67f6d1a3d67b5905ba7b14bba))
* Add date generated to ssh pubkey comment ([235508a](https://www.github.com/agoloncser/desktop-init-scripts/commit/235508a5ee4ef846453fe46111a7481834296bd6))
* Add help and minor fixes ([aa5b14d](https://www.github.com/agoloncser/desktop-init-scripts/commit/aa5b14dd117b85c890ca3a4fef2bb47613e0bd48))
* Add smartmontools ([40cbb8d](https://www.github.com/agoloncser/desktop-init-scripts/commit/40cbb8dd752f96e044ab1522b2bfefbcee61c1f9))
* Automatically create key ([d615b4c](https://www.github.com/agoloncser/desktop-init-scripts/commit/d615b4c43a8e7b4fd1b5f8e890b41a0bc321417c))
* Do not store pubkey in pass ([bfe1cae](https://www.github.com/agoloncser/desktop-init-scripts/commit/bfe1cae87ec4ef30826312e838cbfb2b78f319e6))
* Fix key creation ([bc40de7](https://www.github.com/agoloncser/desktop-init-scripts/commit/bc40de794734e42f873ff6b381c3e62c1560fb95))
* Force generate passphrase on each key generation ([8ad71dc](https://www.github.com/agoloncser/desktop-init-scripts/commit/8ad71dcfa5771b2a8fe52267bb7d4859e50546a1))
* Store pubkey in pass as well ([db914bc](https://www.github.com/agoloncser/desktop-init-scripts/commit/db914bcc55e0e1fefbc458192a7664e16ef75cd9))

## [0.8.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.7.1...v0.8.0) (2022-07-19)


### Features

* Add asdf init scripts ([83d7078](https://www.github.com/agoloncser/desktop-init-scripts/commit/83d7078d02366fa5eba8bbf273c321b28c929f0e))


### Bug Fixes

* Minor script fixes ([a0d32de](https://www.github.com/agoloncser/desktop-init-scripts/commit/a0d32defa095ac69b30b872418579c2b401646d4))

### [0.7.1](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.7.0...v0.7.1) (2022-06-24)


### Bug Fixes

* Ubuntu enable repos ([edd82df](https://www.github.com/agoloncser/desktop-init-scripts/commit/edd82dfcc35702dc34dcebb0163099726212fbb2))

## [0.7.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.6.2...v0.7.0) (2022-05-07)


### Features

* Caps script ([a2c9472](https://www.github.com/agoloncser/desktop-init-scripts/commit/a2c9472d0aee10c5ff2a179cc1c0afcada5c5c78))


### Bug Fixes

* Install pipenv on macos ([027257d](https://www.github.com/agoloncser/desktop-init-scripts/commit/027257d6955c78d7622d9492e26cdc702959c624))
* Update scripts and install pipenv ([c57cded](https://www.github.com/agoloncser/desktop-init-scripts/commit/c57cdedac811316fea6e17086b3c3a47f514ec8b))

### [0.6.2](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.6.1...v0.6.2) (2022-04-25)


### Bug Fixes

* Update packages ([0a10a57](https://www.github.com/agoloncser/desktop-init-scripts/commit/0a10a5766ec23c777d046008215c31b612039152))

### [0.6.1](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.6.0...v0.6.1) (2022-04-24)


### Bug Fixes

* Add wl-clipboard ([3522b66](https://www.github.com/agoloncser/desktop-init-scripts/commit/3522b664bbb348f02fe5a7a4748fbff085fc9c53))

## [0.6.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.5.1...v0.6.0) (2022-04-05)


### Features

* Add ssh key generator script ([db7bf92](https://www.github.com/agoloncser/desktop-init-scripts/commit/db7bf9267a808d268dc077c8963890e09087d564))
* Install homebrew locally ([0491e31](https://www.github.com/agoloncser/desktop-init-scripts/commit/0491e31e6d27adbde265f05797a3cfa377092436))

### [0.5.1](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.5.0...v0.5.1) (2022-03-09)


### Bug Fixes

* Add fish shell on linuxes ([5843188](https://www.github.com/agoloncser/desktop-init-scripts/commit/5843188a30455a4d6a8c8e70877fc3dde4718975))
* Add fish shell on macOS ([ed3d207](https://www.github.com/agoloncser/desktop-init-scripts/commit/ed3d20747e20d8c18cb06c88d6d7050047f4abbe))

## [0.5.0](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.4.3...v0.5.0) (2021-11-16)


### Features

* Add pass-otp ([0b72f76](https://www.github.com/agoloncser/desktop-init-scripts/commit/0b72f76417e817ddf9c4961e551fdf478700bb8c))

### [0.4.3](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.4.2...v0.4.3) (2021-10-28)


### Bug Fixes

* Add rsync ([3557aec](https://www.github.com/agoloncser/desktop-init-scripts/commit/3557aec8cc9dad034e5e60942bafd7a478992af6))
* Remove FreeBSD support ([d680acd](https://www.github.com/agoloncser/desktop-init-scripts/commit/d680acd6ec96378c71d312c048cebbdef593dc03))
* Rename directory ([0d4629c](https://www.github.com/agoloncser/desktop-init-scripts/commit/0d4629c336faae62324b9c7998028028649ce4c9))

### [0.4.2](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.4.1...v0.4.2) (2021-10-08)


### Bug Fixes

* Add bash to Ubuntu ([750a05a](https://www.github.com/agoloncser/desktop-init-scripts/commit/750a05a82e23c2356991c23785a0367fa6f026bc))

### [0.4.1](https://www.github.com/agoloncser/desktop-init-scripts/compare/v0.4.0...v0.4.1) (2021-09-28)


### Bug Fixes

* Use `GNUPGHOME` as for finding GPG home directory. ([c07eda1](https://www.github.com/agoloncser/desktop-init-scripts/commit/c07eda1dbe35fa90722585b39e7aeb23f0e69840))
