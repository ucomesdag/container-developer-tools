# container-developer-tools

Fedora Container Image with tools for developers.

This image is based of the [DevFile Developer Images](https://github.com/devfile/developer-images) with some additional tools.

[![developer-tools container image][quai.io]](https://quay.io/repository/ucomesdag/developer-tools?tab=tags)

## Additional Development Tools

| Tool or language    | Fedora based devtools image         |
|---------------------|-------------------------------------|
|------PYTHON---------|-------------------------------------|
| `tox`               |`<via pip>`                          |
| `pyenv`             |`<https://pyenv.run/>`               |
| `pyton3.10`         |`<via pyenv>`                        |
| `python3.11`        |`<via pyenv`                         |
| `python3.12`        |`<via pyenv`                         |
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
| `buildah`           |`buildah`                            |
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
| `kubedock`          |`<gh releases>`                      |
| `less`              |`less`                               |
| `lsof`              |`lsof`                               |
| `man`               |`man`                                |
| `nano`              |`nano`                               |
| `netcat`            |`NOT AVAILABLE`                      |
| `netstat`           |`net-tools`                          |
| `openssh-client`    |`openssh-clients`                    |
| `podman`            |`podman`                             |
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
| `stow`              |`stow`                               |
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
| `java`              |`<8.0.402-tem via sdkman>`           |
| `java`              |`<11.0.22-tem via sdkman>`           |
| `java`              |`<17.0.10-tem via sdkman>/default`   |
| `java`              |`<21.0.2-tem via sdkman>`   |
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
| `dotnet`            |`dotnet-sdk-8.0`                     |
|------PYTHON---------|-------------------------------------|
| `python`            |`python3.11`                         |
| `setuptools`        |`python3.11-setuptools`              |
| `pip`               |`python3.11-pip`                     |
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
| `tkn`               |`mirror.openshift.com`               |
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
+ JAVA_HOME_21

## Testing

Read how to [test locally](TESTING.md).

<!-- container image -->

[quai.io]: https://img.shields.io/badge/Quay.io-container%20image-green?style=flat&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAIKADAAQAAAABAAAAIAAAAACshmLzAAABSlBMVEUAAAD////////////////////////39/f/+fn/////+fn5+fn69vb///r///v39/L///v48fH7+/v48fH//Pn28e78+fn07+z9+Pjy6+n79/X79/b7+Pbs5eL89vX69/Pr4+D69/Pp4t369vPn39z59fLm3dr49PLk3Nf49PHk2tb38/Hh1tT29PDf1tL28u/38u/d1ND18u/b0s718e708e3Xzsr08e3r5uPz7+3Ty8fw7Ony7+zx7evx7uvw7evMxsPw7erLxcLv7Onv7evJw8Hu7OrFwcDHwsDt7Oru7Oq7u7u8vLy9vLy9vb2+vby/vr3Avr3Av77AwMDBv77BwcHCv77Dw8PEwL/FxcXIyMjLyMbLy8vNzc3Q0NDT09PW1tbY2NjZ2dnb29vd3d3i4uLk5OTo6Ojp6enq6urr6unr6urs6uns6+ryGpEZAAAAS3RSTlMABAgMEBgcICgoLC42Njo8PEhISlJYXF5wdIGHiZOTmZubpaWtrbW1u7vDw8nJ0dHT1dXb29/l5evr7e3t8/P19/f5+fn7+/39/f30Ld0iAAABMElEQVQ4y42TxVYDQRBFK4q7uwUILoFggeBWg1twlxD4/y3z3iBhwSlqdc+r2z09LSL/q/IEajIMDk6BZ6p+CWMvqIsouJN8Hc/uF6WRPTqpoIh/E/x84JRlCUMcdKkaEWkj36jGfvp5GWRP26rrflmicKS6U/gt9DG7UrdaG8l34MGvfugd2ds+wsUkOH0O3sv9FLo5qCeG8Iw8EQFrr9cPbCB7DVc4bvZAoTqYgnAcotDBbEAkrnpKTohEOUUX+r5VZJl8kRrVewq1IjmHENYCrtDMbBTu9Al5FtzPKdpdWuCySxHW3VJoABfsQljxST2zca6mmLzsrX2EUzTJHCeoZDZMocUTSrYgzNuC+QlzkfZvmhtlbrV9WOZx2xfGvHL2pTWvvf1wzKdnP96/6wNJ78x7Y9V/XgAAAABJRU5ErkJggg==&logoColor=white
