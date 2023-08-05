FROM registry.fedoraproject.org/fedora:latest

LABEL maintainer="Uco Mesdag <uco@mesd.ag>"
LABEL build_date="2023-07-23T23:33:16CEST"

ENV container=podman

USER 0

#
# Origin: https://github.com/devfile/developer-images/blob/main/base/ubi8/Dockerfile
#         https://github.com/devfile/developer-images/blob/main/universal/ubi8/Dockerfile
#

COPY --chown=0:0 entrypoint.sh /
RUN \
    # add user and configure it
    useradd -u 1000 -G wheel,root -d /home/user/ --shell /bin/bash -m user && \
    # Setup $PS1 for a consistent and reasonable prompt
    echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`$ '" >> /home/user/.bashrc && \
    # Set permissions on /etc/passwd and /home to allow arbitrary users to write
    chgrp -R 0 /home && \
    chmod -R g=u /etc/passwd /etc/group /home && \
    chmod +x /entrypoint.sh

# Tools
RUN dnf install -y bash bat curl diffutils emacs fd-find fish gh git git-lfs htop iproute jq \
    less lsof man nano net-tools netcat openssh-clients p7zip p7zip-plugins perl-Digest-SHA \
    procps ripgrep rsync screen shellcheck socat sudo time tldr tmux vim wget zip zsh \
    e2fsprogs-static

# Required packages for AWT
RUN dnf install -y libXext libXrender libXtst libXi

# Lombok
ENV LOMBOK_VERSION=1.18.28
RUN wget -O /usr/local/lib/lombok.jar https://projectlombok.org/downloads/lombok-${LOMBOK_VERSION}.jar

# Scala
RUN curl -fLo cs https://git.io/coursier-cli && \
    chmod +x cs && \
    mv cs /usr/local/bin/
RUN curl -fLo sbt https://raw.githubusercontent.com/dwijnand/sbt-extras/master/sbt && \
    chmod +x sbt && \
    mv sbt /usr/local/bin/
RUN curl -fLo mill https://raw.githubusercontent.com/lefou/millw/main/millw && \
    chmod +x mill && \
    mv mill /usr/local/bin/

# C/CPP
RUN dnf -y install llvm gcc gcc-c++ clang clang-libs clang-tools-extra gdb

# Go 1.18+    - installed to /usr/bin/go
# gopls 0.10+ - installed to $HOME/go/bin/gopls and $HOME/go/pkg/mod/
RUN dnf install -y golang && \
    GO111MODULE=on go install -v golang.org/x/tools/gopls@latest
ENV GOBIN="$HOME/go/bin/"
ENV PATH="$GOBIN:$PATH"

# Python
RUN dnf -y install python3 python3-devel python3-setuptools python3-pip nss_wrapper && \
    pip install pylint yq

# Php 8+
RUN dnf install -y --setopt=tsflags=nodocs php php-mysqlnd php-pgsql php-bcmath \
                php-gd php-intl php-json php-ldap php-mbstring php-pdo \
                php-pear php-zlib php-mysqli php-curl php-xml php-devel\
                php-process php-soap php-opcache php-fpm ca-certificates \
                php-gmp php-pecl-xdebug php-pecl-zip mod_ssl hostname && \
    wget https://getcomposer.org/installer -O /tmp/composer-installer.php && \
    php /tmp/composer-installer.php --filename=composer --install-dir=/usr/local/bin

ENV PHP_DEFAULT_INCLUDE_PATH=/usr/share/pear \
    PHP_SYSCONF_PATH=/etc \
    PHP_HTTPD_CONF_FILE=php.conf \
    HTTPD_MAIN_CONF_PATH=/etc/httpd/conf \
    HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d \
    HTTPD_MODULES_CONF_D_PATH=/etc/httpd/conf.modules.d \
    HTTPD_VAR_RUN=/var/run/httpd \
    HTTPD_DATA_PATH=/var/www \
    HTTPD_DATA_ORIG_PATH=/var/www \
    HTTPD_VAR_PATH=/var

# .NET
ENV DOTNET_RPM_VERSION=7.0
RUN dnf install -y dotnet-hostfxr-${DOTNET_RPM_VERSION} dotnet-runtime-${DOTNET_RPM_VERSION} dotnet-sdk-${DOTNET_RPM_VERSION}

# rust
ENV CARGO_HOME=/home/user/.cargo \
    RUSTUP_HOME=/home/user/.rustup \
    PATH=/home/user/.cargo/bin:${PATH}
RUN curl --proto '=https' --tlsv1.2 -sSfo rustup https://sh.rustup.rs && \
    chmod +x rustup && \
    mv rustup /usr/bin/ && \
    rustup -y --no-modify-path --profile minimal -c rust-src -c rust-analysis -c rls

# camel-k
ENV KAMEL_VERSION 1.12.1
RUN curl -L https://github.com/apache/camel-k/releases/download/v${KAMEL_VERSION}/camel-k-client-${KAMEL_VERSION}-linux-64bit.tar.gz | tar -C /usr/local/bin -xz \
    && chmod +x /usr/local/bin/kamel

# git completion
RUN echo "source /usr/share/bash-completion/completions/git" >> /home/user/.bashrc

# Copy the global git configuration to user config as global /etc/gitconfig
#  file may be overwritten by a mounted file at runtime
RUN cp /etc/gitconfig /home/user/.gitconfig

# Cloud

# oc client and completion
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz | tar -C /usr/local/bin -xz \
    && chmod +x /usr/local/bin/oc  \
    && oc completion bash > /usr/share/bash-completion/completions/oc \
    && echo "source /usr/share/bash-completion/completions/oc" >> /home/user/.bashrc

# kubectl
RUN dnf install -y kubernetes-client; \
    curl -sSL -o ~/.kubectl_aliases https://raw.githubusercontent.com/ahmetb/kubectl-alias/master/.kubectl_aliases; \
    echo '[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases' >> /home/user/.bashrc

# krew
RUN \
    TEMP_DIR="$(mktemp -d)"; \
    cd "${TEMP_DIR}"; \
    KREW_VERSION="0.4.4"; \
    KREW_ARCH="linux_amd64"; \
    KREW_TGZ="krew-${KREW_ARCH}.tar.gz"; \
    KREW_TGZ_URL="https://github.com/kubernetes-sigs/krew/releases/download/v${KREW_VERSION}/${KREW_TGZ}"; \
    curl -sSLO "${KREW_TGZ_URL}"; \
    curl -sSLO "${KREW_TGZ_URL}.sha256"; \
    echo "$(cat ${KREW_TGZ}.sha256)  ${KREW_TGZ}" > "${KREW_TGZ}.sha256"; \
    sha256sum -c "${KREW_TGZ}.sha256" 2>&1 | grep OK; \
    tar -zxvf "${KREW_TGZ}"; \
    ./"krew-${KREW_ARCH}" install krew; \
    echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> /home/user/.bashrc; \
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"; \
    kubectl krew install ns; \
    kubectl krew install ctx; \
    cd -; \
    rm -rf "${TEMP_DIR}"

# helm kustomize
RUN dnf install -y helm golang-sigs-k8s-kustomize

# tektoncd-cli
RUN \
    TEMP_DIR="$(mktemp -d)"; \
    cd "${TEMP_DIR}"; \
    TKN_VERSION="0.31.1"; \
    TKN_ARCH="Linux_x86_64"; \
    TKN_TGZ="tkn_${TKN_VERSION}_${TKN_ARCH}.tar.gz"; \
    TKN_TGZ_URL="https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/${TKN_TGZ}"; \
    TKN_CHEKSUMS_URL="https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/checksums.txt"; \
    curl -sSLO "${TKN_TGZ_URL}"; \
    curl -sSLO "${TKN_CHEKSUMS_URL}"; \
    sha256sum --ignore-missing -c "checksums.txt" 2>&1 | grep OK; \
    tar -zxvf "${TKN_TGZ}"; \
    mv tkn /usr/local/bin/; \
    cd -; \
    rm -rf "${TEMP_DIR}"

# knative-cli
RUN \
    TEMP_DIR="$(mktemp -d)"; \
    cd "${TEMP_DIR}"; \
    KN_VERSION="1.10.0"; \
    KN_ARCH="linux-amd64"; \
    KN_BIN="kn-${KN_ARCH}"; \
    KN_BIN_URL="https://github.com/knative/client/releases/download/v${KN_VERSION}/${KN_BIN}"; \
    KN_CHEKSUMS_URL="https://github.com/knative/client/releases/download/v${KN_VERSION}/checksums.txt"; \
    curl -sSLO "${KN_BIN_URL}"; \
    curl -sSLO "${KN_CHEKSUMS_URL}"; \
    sha256sum --ignore-missing -c "checksums.txt" 2>&1 | grep OK; \
    mv "${KN_BIN}" kn; \
    chmod +x kn; \
    mv kn /usr/local/bin; \
    cd -; \
    rm -rf "${TEMP_DIR}"

# terraform-cli
RUN \
    TEMP_DIR="$(mktemp -d)"; \
    cd "${TEMP_DIR}"; \
    TF_VERSION="1.5.3"; \
    TF_ARCH="linux_amd64"; \
    TF_ZIP="terraform_${TF_VERSION}_${TF_ARCH}.zip"; \
    TF_ZIP_URL="https://releases.hashicorp.com/terraform/${TF_VERSION}/${TF_ZIP}"; \
    TF_CHEKSUMS_URL="https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS"; \
    curl -sSLO "${TF_ZIP_URL}"; \
    curl -sSLO "${TF_CHEKSUMS_URL}"; \
    sha256sum --ignore-missing -c "terraform_${TF_VERSION}_SHA256SUMS" 2>&1 | grep OK; \
    unzip ${TF_ZIP}; \
    chmod +x terraform; \
    mv terraform /usr/local/bin; \
    cd -; \
    rm -rf "${TEMP_DIR}"

# docker docker-compose
RUN dnf install -y moby-engine docker-compose

# PyEnv dependencies
RUN dnf install -y bzip2-devel ncurses-devel libffi-devel sqlite-devel readline-devel

#
# Origin: https://github.com/containers/podman/blob/main/contrib/podmanimage/stable/Containerfile
#

# podman buildah skopeo

# Don't include container-selinux and remove
# directories used by dnf that are just taking
# up space.
# TODO: rpm --setcaps... needed due to Fedora (base) image builds
#       being (maybe still?) affected by
#       https://bugzilla.redhat.com/show_bug.cgi?id=1995337#c3
RUN dnf -y update && \
    rpm --setcaps shadow-utils 2>/dev/null && \
    dnf -y install podman podman-compose buildah skopeo fuse-overlayfs openssh-clients \
        --exclude container-selinux

# Tweaks to make rootless buildah work
RUN touch /etc/subgid /etc/subuid && \
    chmod g=u /etc/subgid /etc/subuid /etc/passwd && \
    echo -e "user:1:999\nuser:1001:64535" > /etc/subuid && \
    echo -e "user:1:999\nuser:1001:64535" > /etc/subgid

ARG _REPO_URL="https://raw.githubusercontent.com/containers/podman/main/contrib/podmanimage/stable"
ADD $_REPO_URL/containers.conf /etc/containers/containers.conf
ADD $_REPO_URL/podman-containers.conf /home/podman/.config/containers/containers.conf

RUN mkdir -p /home/user/.local/share/containers && \
    chown -R 1000:0 /home/user && \
    chmod 644 /etc/containers/containers.conf

# Copy & modify the defaults to provide reference if runtime changes needed.
# Changes here are required for running with fuse-overlay storage inside container.
RUN sed -e 's|^#mount_program|mount_program|g' \
           -e '/additionalimage.*/a "/var/lib/shared",' \
           -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' \
           /usr/share/containers/storage.conf \
           > /etc/containers/storage.conf

# Note VOLUME options must always happen after the chown call above
# RUN commands can not modify existing volumes
VOLUME /var/lib/containers
VOLUME /home/user/.local/share/containers

RUN mkdir -p /var/lib/shared/overlay-images \
             /var/lib/shared/overlay-layers \
             /var/lib/shared/vfs-images \
             /var/lib/shared/vfs-layers && \
    touch /var/lib/shared/overlay-images/images.lock && \
    touch /var/lib/shared/overlay-layers/layers.lock && \
    touch /var/lib/shared/vfs-images/images.lock && \
    touch /var/lib/shared/vfs-layers/layers.lock

ENV _CONTAINERS_USERNS_CONFIGURED=""

# Fix for podman: use VFS since Fuse does not work yet...
RUN mkdir -p /home/user/.config/containers && \
    (echo '[storage]';echo 'driver = "vfs"') > /home/user/.config/containers/storage.conf

# Cleanup dnf cache
RUN dnf -y clean all --enablerepo='*'; \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# Fix user home permissions
RUN chown -R 1000:0 /home/user && \
    chmod -R g=u /home/user

# Set user and entrypoint
USER 1000
WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]

# User space tools

# kube
ENV KUBECONFIG=/home/user/.kube/config

# Java
RUN curl -fsSL "https://get.sdkman.io" | bash \
    && bash -c ". /home/user/.sdkman/bin/sdkman-init.sh \
             && sed -i "s/sdkman_auto_answer=false/sdkman_auto_answer=true/g" /home/user/.sdkman/etc/config \
	     && sed -i "s/sdkman_auto_env=false/sdkman_auto_env=true/g" /home/user/.sdkman/etc/config \
             && sdk install java 8.0.332-tem \
             && sdk install java 11.0.15-tem \
             && sdk install java 17.0.3-tem \
             && sdk install java 22.1.0.0.r17-mandrel \
             && sdk default java 11.0.15-tem \
             && sdk install gradle \
             && sdk install maven \
             && sdk install jbang \
             && sdk flush archives \
             && sdk flush temp"

# sdk home java <version>
ENV JAVA_HOME_8=/home/user/.sdkman/candidates/java/8.0.332-tem
ENV JAVA_HOME_11=/home/user/.sdkman/candidates/java/11.0.15-tem
ENV JAVA_HOME_17=/home/user/.sdkman/candidates/java/17.0.3-tem

# Java-related environment variables are described and set by /home/user/.bashrc
# To make Java working for dash and other shells, it needs to initialize them in the Dockerfile.
ENV SDKMAN_CANDIDATES_API="https://api.sdkman.io/2"
ENV SDKMAN_CANDIDATES_DIR="/home/user/.sdkman/candidates"
ENV SDKMAN_DIR="/home/user/.sdkman"
ENV SDKMAN_PLATFORM="linuxx64"
ENV SDKMAN_VERSION="5.13.0"

ENV GRADLE_HOME="/home/user/.sdkman/candidates/gradle/current"
ENV JAVA_HOME="/home/user/.sdkman/candidates/java/current"
ENV MAVEN_HOME="/home/user/.sdkman/candidates/maven/current"

ENV GRAALVM_HOME=/home/user/.sdkman/candidates/java/22.1.0.0.r17-mandrel

ENV PATH="/home/user/.krew/bin:$PATH"
ENV PATH="/home/user/.sdkman/candidates/maven/current/bin:$PATH"
ENV PATH="/home/user/.sdkman/candidates/java/current/bin:$PATH"
ENV PATH="/home/user/.sdkman/candidates/gradle/current/bin:$PATH"
ENV PATH="/home/user/.local/share/coursier/bin:$PATH"

# NodeJS
ENV NVM_DIR="/home/user/.nvm"
ENV NODEJS_12_VERSION=12.22.12
ENV NODEJS_14_VERSION=14.21.3
ENV NODEJS_16_VERSION=16.20.1
ENV NODEJS_18_VERSION=18.17.0
ENV NODEJS_20_VERSION=20.5.0
RUN mkdir -p $NVM_DIR; curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN bash -c "source /home/user/.bashrc && \
    nvm install v${NODEJS_12_VERSION} && \
    nvm install v${NODEJS_14_VERSION} && \
    nvm install v${NODEJS_16_VERSION} && \
    nvm install v${NODEJS_18_VERSION} && \
    nvm install v${NODEJS_20_VERSION} && \
    nvm alias default v$NODEJS_VERSION && \
    nvm use v$NODEJS_18_VERSION && \
    npm install --global yarn@v1.22.19"
ENV PATH=$NVM_DIR/versions/node/v$NODEJS_VERSION/bin:$PATH
ENV NODEJS_HOME_12=$NVM_DIR/versions/node/v$NODEJS_12_VERSION
ENV NODEJS_HOME_14=$NVM_DIR/versions/node/v$NODEJS_14_VERSION
ENV NODEJS_HOME_16=$NVM_DIR/versions/node/v$NODEJS_16_VERSION
ENV NODEJS_HOME_18=$NVM_DIR/versions/node/v$NODEJS_18_VERSION
ENV NODEJS_HOME_20=$NVM_DIR/versions/node/v$NODEJS_20_VERSION

# Ansible
RUN pip install tox podman molecule molecule-plugins[podman] testinfra ansible-later ansible-lint yamllint selinux pre-commit

# PyEnv
ENV PYTHON_CONFIGURE_OPTS="--disable-ipv6"
RUN curl https://pyenv.run | bash  && \
    echo 'export PATH="/home/user/.pyenv/bin:$PATH"' >> /home/user/.bashrc  && \
    echo 'eval "$(pyenv init -)"' >> /home/user/.bashrc && \
    export PATH="/home/user/.pyenv/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    pyenv install 3.10 3.11 && \
    chmod -R go=u /home/user/.pyenv/shims
