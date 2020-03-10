FROM chatwork/alpine-sdk:3.11

LABEL version="2.5.0"
LABEL maintainer="akatsu@chatwork.com"

ENV PROTOBUF_VERSION="2.5.0"

RUN apk add --no-cache build-base curl automake autoconf libtool git zlib-dev && \
    mkdir -p /protobuf && \
    curl -L https://github.com/google/protobuf/archive/v${PROTOBUF_VERSION}.tar.gz | tar xvz --strip-components=1 -C /protobuf && \
    cd /protobuf && \
    autoreconf -f -i -Wall,no-obsolete && \
    ./configure --prefix=/usr --enable-static=no && \
    make -j2 && \
    make install