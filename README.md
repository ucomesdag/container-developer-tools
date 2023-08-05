# container-developer-tools

A Fedora based container with tools for developers.

This image is based of the [DevFile Developer Images](https://github.com/devfile/developer-images) with some additional tools.

[![developer-tools build status](https://quay.io/repository/ucomesdag/developer-tools/status "Container Repository on Quay")](https://quay.io/repository/ucomesdag/developer-tools)

## Additional Development Tools

| Tool or language    | Fedora based devtools image         |
|---------------------|-------------------------------------|
|------PYTHON---------|-------------------------------------|
| `tox`               |`<via pip>`                          |
| `pyenv`             |`<https://pyenv.run/>`               |
| `pyton3.10`         |`<via pyenv>`                        |
| `python3.11`        |`<via pyenv`                         |
|--------CLOUD--------|-------------------------------------|
| `podman-compose`    |`podman-compose`                     |
| `ansible`           |`<via pip>`                          |
| `ansible-better`    |`<via pip>`                          |
| `ansible-lint`      |`<via pip>`                          |
| `yamllint`          |`<via pip>`                          |
| `molecule`          |`<via pip>`                          |

## Included Development Tools from the Developer Images

| Tool                | ubi8 based image                    |
|---------------------|-------------------------------------|
| `bash`              |`bash`                               |
| `bat`               |`<gh releases>`                      |
| `curl`              |`curl`                               |
| `ps`                |`ps`                                 |
| `diff`              |`diffutils`                          |
| `emacs`             |`NOT AVAILABLE (fedora only)`        |
| `fish`              |`NOT AVAILABLE (fedora only)`        |
| `gh`                |`<gh releases>`                      |
| `git`               |`git`                                |
| `git-lfs`           |`git-lfs`                            |
| `ip`                |`iproute`                            |
| `jq`                |`jq`                                 |
| `htop`              |`NOT AVAILABLE (fedora only)`        |
| `less`              |`less`                               |
| `lsof`              |`lsof`                               |
| `man`               |`man`                                |
| `nano`              |`nano`                               |
| `netcat`            |`NOT AVAILABLE`                      |
| `netstat`           |`net-tools`                          |
| `openssh-client`    |`openssh-clients`                    |
| `7z`                |`p7zip-plugins`                      |
| `ripgrep`           |`<gh releases>`                      |
| `rsync`             |`rsync`                              |
| `scp`               |`openssh-clients`                    |
| `screen`            |`NOT AVAILABLE`                      |
| `sed`               |`sed`                                |
| `shasum`            |`perl-Digest-SHA`                    |
| `socat`             |`socat`                              |
| `sudo`              |`sudo`                               |
| `ss`                |`NOT AVAILABLE`                      |
| `ssl-cert`          |`NOT AVAILABLE`                      |
| `tail`              |`<built in>`                         |
| `tar`               |`tar`                                |
| `time`              |`time`                               |
| `tldr`              |`NOT AVAILABLE (fedora only)`        |
| `tmux`              |`NOT AVAILABLE (fedora only)`        |
| `vim`               |`vim`                                |
| `wget`              |`wget`                               |
| `zip`               |`zip`                                |
| `zsh`               |`NOT AVAILABLE (fedora only)`        |
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
|--------PHP----------|-------------------------------------|
| `php`               |`php`                                |
| `composer`          |`https://getcomposer.org/`           |
| `xdebug`            |`pecl`                               |
|-------NODEJS--------|-------------------------------------|
| `nodejs`            |`nodejs`                             |
| `npm`               |`npm`                                |
| `yarn`              |`<via npm>`                          |
|--------GO-----------|-------------------------------------|
| `go`                |`go-toolset`                         |
| `gopls`             |`golang.org/x/tools/gopls`           |
|--------.NET---------|-------------------------------------|
| `dotnet`            |`dotnet-sdk-6.0`                     |
|------PYTHON---------|-------------------------------------|
| `python`            |`python39`                           |
| `setuptools`        |`python39-setuptools`                |
| `pip`               |`python39-pip`                       |
| `pylint`            |`<via pip>`                          |
| `yq`                |`<via pip>`                          |
|--------RUST---------|-------------------------------------|
| `rustup`            |`<sh.rustup.rs>`                     |
| `rust-src`          |`<via rustup>`                       |
| `rust-analysis`     |`<via rustup>`                       |
|--------Platform-----|-------------------------------------|
| `camel-k`           |`<gh release>`                       |
|------CLOUD----------|-------------------------------------|
| `oc`                |`mirror.openshift.com`               |
| `podman`            |`container-tools:rhel8`              |
| `buildah`           |`container-tools:rhel8`              |
| `skopeo`            |`container-tools:rhel8`              |
| `kubectl`           |`<kubernetes dnf repo>`              |
| `krew`              |`<gh releases>`                      |
| `helm`              |`<get.helm.sh>`                      |
| `kustomize`         |`<gh releases>`                      |
| `tkn`               |`<gh releases>`                      |
| `kn`                |`<gh releases>`                      |
| `terraform`         |`<releases.hashicorp.com>`           |
| `docker`            |`<download.docker.com>`              |
| `docker-compose`    |`<gh releases>`                      |
| `kamel`             |`<gh release>`                       |

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

## Testing

Read how to [test locally](TESTING.md).
