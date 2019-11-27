FROM alpine:3.10

MAINTAINER dodo <dodocat6666@hotmail.com>

ENV KUBE_VERSION=v1.16.0 \
    KUSTOMIZE_VERSION=3.2.3

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add --update gettext \
    && apk add --update git

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_kustomize.v${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize

RUN apk del --purge deps \
    && rm /var/cache/apk/*

# 这里添加是因为kubectl自带的kustomize版本太低
# 所以手动加新版本的
# ENTRYPOINT ["kubectl"]
CMD kubectl && kustomize