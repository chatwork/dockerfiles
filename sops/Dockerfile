FROM chatwork/alpine-sdk:3.8

ARG SOPS_VERSION=3.2.0

LABEL version="${SOPS_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux /usr/local/bin/sops

RUN chmod 755 /usr/local/bin/sops

ENTRYPOINT ["/usr/local/bin/sops"]
CMD ["help"]
