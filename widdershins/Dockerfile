ARG NODE_VERSION=15.14-alpine

FROM node:${NODE_VERSION}

ARG WIDDERSHINS_VERSION=4.0.1

LABEL version="${WIDDERSHINS_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN npm install -g widdershins \
    && apk update \
    && apk add git \
    && apk add openssh \
    && apk add curl \
    && mkdir /widdershins

WORKDIR /widdershins

ENTRYPOINT ["widdershins"]
