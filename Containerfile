FROM quay.io/devfile/universal-developer-image:latest

LABEL maintainer="Uco Mesdag <uco@mesd.ag>"
LABEL build_date="2023-08-05T13:27:35CEST"

ENV container=podman

USER 0

# podman
RUN dnf install -y http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/python3-click-6.7-8.el8.noarch.rpm && \
    dnf install -y podman-compose

# PyEnv dependencies
RUN dnf install -y http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/readline-devel-7.0-10.el8.x86_64.rpm && \
    dnf install -y bzip2-devel ncurses-devel libffi-devel sqlite-devel

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
    pyenv install 3.10 3.11 && \
    chmod -R go=u /home/user/.pyenv/shims

USER 0

# Cleanup dnf cache
RUN dnf -y clean all --enablerepo='*' && \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# Fix user home permissions
RUN chown -R 10001:0 /home/user && \
    chmod -R g=u /home/user

USER 10001
