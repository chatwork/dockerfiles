ARG NODE_VERSION=lts-buster

FROM circleci/node:${NODE_VERSION}

ARG WIDDERSHINS_VERSION=4.0.1

LABEL version="${WIDDERSHINS_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN sudo npm install -g widdershins \
    && sudo mkdir /widdershins

WORKDIR /widdershins

ENTRYPOINT ["widdershins"]
