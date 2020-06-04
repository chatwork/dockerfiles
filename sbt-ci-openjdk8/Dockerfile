FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u252-b09-slim

ARG SBT_VERSION=1.3.10

LABEL version="jdk8u252-b09-$SBT_VERSION"
LABEL maintainer="Megumu Katsuno <katsuno@chatwork.com>"

ENV LANG=C.UTF-8

RUN curl -L -o /tmp/sbt.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i /tmp/sbt.deb && \
    rm /tmp/sbt.deb && \
    apt-get update && \
    apt-get install -y \
    sbt \
    libaio1 \
    git \
    unzip \
    python \
    openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o /tmp/awscli-bundle.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    unzip /tmp/awscli-bundle.zip -d /tmp/ && \
    /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    rm -rf /tmp/awscli-bundle.zip /tmp/awscli-bundle

RUN curl -o /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz && \
    tar xzvf /tmp/docker.tgz && \
    cp docker/* /usr/bin && \
    rm -rf /tmp/docker.tgz ./docker

WORKDIR /root
