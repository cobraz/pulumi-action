FROM pulumi/pulumi-nodejs:latest

RUN apt-get update -y && \
    apt-get install -y \
    curl

ENV XDG_CONFIG_HOME=/root/.config
ENV XDG_CACHE_HOME=/root/.cache
RUN curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
    helm repo add stable https://kubernetes-charts.storage.googleapis.com && \
    helm repo update

RUN curl -o /usr/bin/pulumi-action \
    https://raw.githubusercontent.com/pulumi/pulumi/master/dist/actions/entrypoint.sh && \
    chmod +x /usr/bin/pulumi-action

ENTRYPOINT ["/usr/bin/pulumi-action", "--non-interactive"]