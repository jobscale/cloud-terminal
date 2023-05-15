FROM ghcr.io/jobscale/wetty
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y lsb-release software-properties-common \
  ca-certificates apt-transport-https gpg \
  git unzip tmux iproute2 dnsutils netcat whois

# Kubernetes (kubectl)
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/$( \
      curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
    )/bin/linux/amd64/kubectl \
 && chmod +x kubectl && mv kubectl /usr/local/bin

# GCP (gke)
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
 && sudo apt-get update && sudo apt-get install -y google-cloud-cli

# AWS (eks)
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && ./aws/install && rm -fr aws awscliv2.zip
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
 && mv /tmp/eksctl /usr/local/bin

# Azure (aks) TODO: not release with buster
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN rm -fr /var/lib/apt/lists/*
WORKDIR /home/node/task
COPY --chown=node:staff . /home/node/task
