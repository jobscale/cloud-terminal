FROM jobscale/wetty
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y lsb-release software-properties-common apt-transport-https
# Kubernetes (kubectl)
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/$( \
      curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt \
    )/bin/linux/amd64/kubectl \
 && chmod +x kubectl && mv kubectl /usr/local/bin
# GCP (gke)
RUN (curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -) \
 && add-apt-repository "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -cs) main" \
 && apt-get update && apt-get install -y google-cloud-sdk
# AWS (eks)
RUN apt-get install -y python3-pip && pip3 install awscli
RUN curl -sO https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x aws-iam-authenticator && mv aws-iam-authenticator /usr/local/bin \
 && curl -sL "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
 && mv /tmp/eksctl /usr/local/bin
# Azure (aks) TODO: not release with buster
RUN (curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -) \
 && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(echo stretch) main" \
 && apt-get update && apt-get install -y azure-cli
RUN rm -fr /var/lib/apt/lists/*
COPY . /home/buster
