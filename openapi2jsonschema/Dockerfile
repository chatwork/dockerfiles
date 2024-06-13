FROM buildpack-deps:scm

ARG OPENAPI2JSONSCHEMA_VERSION=0.9.1

LABEL version="${OPENAPI2JSONSCHEMA_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apt-get update  \
    && apt-get install -y --no-install-recommends python3 python3-pip \
    && pip3 install --break-system-packages --no-cache-dir pyyaml==5.3.1 \
    && pip3 install --break-system-packages --no-cache-dir openapi2jsonschema==${OPENAPI2JSONSCHEMA_VERSION} \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /openapi2jsonschema

ENTRYPOINT ["/usr/local/bin/openapi2jsonschema"]
CMD ["--help"]
