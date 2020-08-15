FROM jobscale/wetty
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y lsb-release software-properties-common apt-transport-https

# Kubernetes (kubectl)
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/$( \
      curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
    )/bin/linux/amd64/kubectl \
 && chmod +x kubectl && mv kubectl /usr/local/bin

# GCP (gke)
RUN curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-302.0.0-linux-x86_64.tar.gz | tar xz -C /tmp \
 && /tmp/google-cloud-sdk/install.sh

# AWS (eks)
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip && ./aws/install && rm -fr aws awscliv2.zip
RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
 && mv /tmp/eksctl /usr/local/bin

# Azure (aks) TODO: not release with buster
RUN (curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -) \
 && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(echo stretch) main" \
 && apt-get update && apt-get install -y azure-cli

RUN rm -fr /var/lib/apt/lists/*
COPY . /home/buster
