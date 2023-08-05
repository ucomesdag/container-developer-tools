FROM quay.io/devfile/universal-developer-image:latest

ARG BUILD_DATE

LABEL summary="Fedora Container Image with tools for developers."
LABEL maintainer="Uco Mesdag <uco@mesd.ag>"
LABEL build-date=${BUILD_DATE}

ENV container=podman

USER 0

# podman
RUN dnf install -y podman-compose

# PyEnv dependencies
RUN dnf install -y bzip2-devel ncurses-devel libffi-devel sqlite-devel readline-devel libuuid-devel

# Fix UID/GIDs for podman
RUN echo -e "user:1:10000\nuser:10002:64535" > /etc/subuid && \
    echo -e "user:1:10000\nuser:10002:64535" > /etc/subgid

USER 10001

# Ansible
RUN pip install tox podman molecule molecule-plugins[podman] testinfra ansible-later ansible-lint yamllint selinux pre-commit && \
    echo 'export PATH="/home/user/.local/bin:$PATH"' >> /home/user/.bashrc

# PyEnv
ENV PYTHON_CONFIGURE_OPTS="--disable-ipv6"
RUN curl https://pyenv.run | bash  && \
    echo 'export PATH="/home/user/.pyenv/bin:$PATH"' >> /home/user/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> /home/user/.bashrc && \
    export PATH="/home/user/.pyenv/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    pyenv install 3.10 3.11 3.12 && \
    chmod -R go=u /home/user/.pyenv/shims

USER 0

# Cleanup dnf cache
RUN dnf -y clean all --enablerepo='*' && \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# Fix user home permissions
RUN chown -R 10001:0 /home/user && \
    chmod -R g=u /home/user

USER 10001
