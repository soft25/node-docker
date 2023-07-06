FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    sudo \
    dpkg \
    iputils-ping \
    jq \
    lsb-release \
    openssl \
    unzip \
    python3-pip \
    software-properties-common \

## Install Ansible

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

# Add user azagent
RUN useradd -m -s /bin/bash azagent \
    && echo 'azagent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /etc/sudoers.d \
    && echo 'azagent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/azagent \
    && chmod 0440 /etc/sudoers.d/azagent

# Set azgent as owner
RUN chown -R azagent:azagent /azp

# Install sudo
RUN apt-get update && apt-get install -y sudo

# Switch to the az-agent user (non root)
USER azagent

ENTRYPOINT [ "./start.sh" ]
