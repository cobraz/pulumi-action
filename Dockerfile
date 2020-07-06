FROM pulumi/pulumi-nodejs:latest


RUN apt-get update -y && \
    apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common \
    wget && \
    # Get all of the signatures we need all at once.
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key  | apt-key add - && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg              | apt-key add - && \
    curl -fsSL https://download.docker.com/linux/debian/gpg          | apt-key add - && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc     | apt-key add - && \
    # IAM Authenticator for EKS
    curl -fsSLo /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/bin/aws-iam-authenticator && \
    # Add additional apt repos all at once
    echo "deb https://deb.nodesource.com/node_12.x $(lsb_release -cs) main"                         | tee /etc/apt/sources.list.d/node.list             && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main"                                           | tee /etc/apt/sources.list.d/yarn.list             && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"      | tee /etc/apt/sources.list.d/docker.list           && \
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -cs) main"               | tee /etc/apt/sources.list.d/google-cloud-sdk.list && \
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main"                                     | tee /etc/apt/sources.list.d/kubernetes.list       && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure.list            && \
    # Install second wave of dependencies
    apt-get update -y && \
    apt-get install -y \
    azure-cli \
    docker-ce \
    google-cloud-sdk \
    kubectl \
    nodejs \
    yarn && \
    pip install awscli --upgrade && \
    # Clean up the lists work
    rm -rf /var/lib/apt/lists/*

ENV XDG_CONFIG_HOME=/root/.config
ENV XDG_CACHE_HOME=/root/.cache
RUN curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
    helm repo add stable https://kubernetes-charts.storage.googleapis.com && \
    helm repo update

RUN curl -o /usr/bin/pulumi-action \
    https://raw.githubusercontent.com/pulumi/pulumi/master/dist/actions/entrypoint.sh && \
    chmod +x /usr/bin/pulumi-action

ENTRYPOINT ["/usr/bin/pulumi-action", "--non-interactive"]