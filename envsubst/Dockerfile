FROM chatwork/alpine-sdk:3.12

ARG ENVSUBST_VERSION=1.3.0

LABEL version="v${ENVSUBST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/a8m/envsubst/releases/download/v${ENVSUBST_VERSION}/envsubst-Linux-x86_64 /usr/local/bin/envsubst
RUN chmod 755 /usr/local/bin/envsubst

ENTRYPOINT ["/usr/local/bin/envsubst"]
CMD ["-help"]
