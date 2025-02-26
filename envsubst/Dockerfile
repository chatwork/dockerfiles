FROM chatwork/alpine-sdk:3.16

ARG ENVSUBST_VERSION=1.4.3

LABEL version="${ENVSUBST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/a8m/envsubst/releases/download/v${ENVSUBST_VERSION}/envsubst-Linux-x86_64 /usr/local/bin/envsubst
RUN chmod 755 /usr/local/bin/envsubst

ENTRYPOINT ["/usr/local/bin/envsubst"]
CMD ["-help"]
