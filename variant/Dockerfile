FROM alpine:latest

ARG VARIANT_VERSION=0.38.0
ARG TARGETARCH

LABEL version="${VARIANT_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

ADD https://github.com/mumoshu/variant/releases/download/v${VARIANT_VERSION}/variant_${VARIANT_VERSION}_linux_${TARGETARCH}.tar.gz /tmp
RUN tar -zxvf /tmp/*.tar.gz -C /tmp \
    && cp /tmp/variant /usr/local/bin/variant \
    && chown root:root /usr/local/bin/variant \
    && chmod 755 /usr/local/bin/variant

VOLUME ["/variant"]
WORKDIR /variant

ENTRYPOINT ["/usr/local/bin/variant"]
CMD ["--help"]
