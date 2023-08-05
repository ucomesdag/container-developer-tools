# container-developer-tools

A Fedora based container containing development tools.

[![developer-tools build status](https://quay.io/repository/ucomesdag/developer-tools/status "Container Repository on Quay")](https://quay.io/repository/ucomesdag/developer-tools)


## Included Development Tools

| Tool or language    | Fedora based image                  |
|---------------------|-------------------------------------|
| `7z`                |`p7zip-plugins`                      |
| `bash`              |`bash`                               |
| `bat`               |`bat`                                |
| `curl`              |`curl`                               |
| `diff`              |`diffutils`                          |
| `emacs`             |`emacs`                              |
| `fish`              |`fish`                               |
| `gh`                |`gh`                                 |
| `git-lfs`           |`git-lfs`                            |
| `git`               |`git`                                |
| `htop`              |`htop`                               |
| `ip`                |`iproute`                            |
| `jq`                |`jq`                                 |
| `less`              |`less`                               |
| `lsof`              |`lsof`                               |
| `man`               |`man`                                |
| `nano`              |`nano`                               |
| `netcat`            |`netcat`                             |
| `netstat`           |`net-tools`                          |
| `openssh-client`    |`openssh-clients`                    |
| `pre-commit`        |`<via pip>`                          |
| `ps`                |`ps`                                 |
| `ripgrep`           |`ripgrep`                            |
| `rsync`             |`rsync`                              |
| `scp`               |`openssh-clients`                    |
| `screen`            |`screen`                             |
| `sed`               |`sed`                                |
| `shasum`            |`perl-Digest-SHA`                    |
| `shellcheck`        |`shellcheck`                         |
| `socat`             |`socat`                              |
| `ss`                |`ss`                                 |
| `ssl-cert`          |`NOT AVAILABLE`                      |
| `sudo`              |`sudo`                               |
| `tail`              |`<built in>`                         |
| `tar`               |`tar`                                |
| `time`              |`time`                               |
| `tldr`              |`tldr`                               |
| `tmux`              |`tmux`                               |
| `vim`               |`vim`                                |
| `wget`              |`wget`                               |
| `zip`               |`zip`                                |
| `zsh`               |`zsh`                                |
|--------JAVA---------|-------------------------------------|
| `sdk`               |`<https://get.sdkman.io>`            |
| `java`              |`<8.0.332-tem via sdkman>`           |
| `java`              |`<11.0.15-tem via sdkman>/default`   |
| `java`              |`<17.0.3-tem via sdkman>`            |
| `maven`             |`<via sdkman>`                       |
| `gradle`            |`<via sdkman>`                       |
| `mandrel`           |`<22.1.0.0.r17-mandrel via sdkman>`  |
| `jbang`             |`<via sdkman>`                       |
|--------SCALA--------|-------------------------------------|
| `cs`                |`<https://get-coursier.io/>`         |
| `sbt`               |`<sbt launch script>`                |
| `mill`              |`<mill launch script>`               |
|--------C/CPP--------|-------------------------------------|
| `clang`             |`clang`                              |
| `clangd`            |`llvm-toolset`                       |
| `gdb`               |`gdb`                                |
|---------PHP---------|-------------------------------------|
| `php`               |`php8`                               |
| `composer`          |`<https://getcomposer.org/>`         |
| `xdebug`            |`pecl`                               |
|-------NODEJS--------|-------------------------------------|
| `nvm`               |`<0.39.1 via gh release>`            |
| `nodejs`            |`<12.22.12 via nvm>`                 |
| `nodejs`            |`<14.21.3 via nvm>`                  |
| `nodejs`            |`<16.20.1 via nvm>`                  |
| `nodejs`            |`<18.17.0 via nvm>/default`          |
| `nodejs`            |`<20.5.0 via nvm>`                   |
| `npm`               |`npm`                                |
| `yarn`              |`<via npm>`                          |
|---------GO----------|-------------------------------------|
| `go`                |`go-toolset`                         |
| `gopls`             |`golang.org/x/tools/gopls`           |
|--------.NET---------|-------------------------------------|
| `dotnet`            |`dotnet-sdk-7.0`                     |
|-------PYTHON--------|-------------------------------------|
| `python`            |`python39`                           |
| `setuptools`        |`python39-setuptools`                |
| `pip`               |`python39-pip`                       |
| `pylint`            |`<via pip>`                          |
| `yq`                |`<via pip>`                          |
| `tox`               |`<via pip>`                          |
| `pyenv`             |`<https://pyenv.run/>`               |
| `pyton3.10`         |`<via pyenv>`                        |
| `python3.11`        |`<via pyenv`                         |
|--------RUST---------|-------------------------------------|
| `rustup`            |`<sh.rustup.rs>`                     |
| `rust-src`          |`<via rustup>`                       |
| `rust-analysis`     |`<via rustup>`                       |
|-------PLATFORM------|-------------------------------------|
| `camel-k`           |`<1.12.1 via gh release>`            |
|--------CLOUD--------|-------------------------------------|
| `oc`                |`<https://mirror.openshift.com/>`    |
| `podman`            |`podman`                             |
| `podman-compose`    |`podman-compose`                     |
| `buildah`           |`buildah`                            |
| `skopeo`            |`skopeo`                             |
| `kubectl`           |`kubernetes-client`                  |
| `krew`              |`<0.4.4 via gh release>`             |
| `helm`              |`helm`                               |
| `kustomize`         |`golang-sigs-k8s-kustomize`          |
| `tkn`               |`<0.31.1 via gh release>`            |
| `kn`                |`<1.10.0 via gh release>`            |
| `terraform`         |`<1.5.3 via releases.hashicorp.com >`|
| `docker`            |`moby-engine`                        |
| `docker-compose`    |`docker-compose`                     |
| `kamel`             |`<1.12.1 via gh release>`            |
| `ansible`           |`<via pip>`                          |
| `ansible-better`    |`<via pip>`                          |
| `ansible-lint`      |`<via pip>`                          |
| `yamllint`          |`<via pip>`                          |
| `molecule`          |`<via pip>`                          |
| **TOTAL SIZE**      | **8.06GB**                          |

## Included libraries
+ e2fsprogs v1.46.5

## Environment Variables

### Java
+ JAVA_HOME_8
+ JAVA_HOME_11
+ JAVA_HOME_17

### Node.js
+ NODEJS_HOME_12
+ NODEJS_HOME_14
+ NODEJS_HOME_16
+ NODEJS_HOME_18
+ NODEJS_HOME_20

## Testing

Read how to [test locally](TESTING.md).
