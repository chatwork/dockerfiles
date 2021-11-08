FROM eclipse-temurin:11.0.13_8-jre-focal

ARG SBT_VERSION=1.5.5
ARG AWS_CLI_VERSION=2.0.30
ARG DOCKER_VERSION=20.10.7

LABEL version="jdk-11.0.13_8-$SBT_VERSION"
LABEL maintainer="Ryo Abe <ryo.abe@chatwork.com>"

ENV LANG=C.UTF-8

RUN apt-get update -y && apt-get install -y gnupg2 && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
    apt-get update && \
    apt-get install -y \
    sbt=${SBT_VERSION} \
    libaio1 \
    git \
    unzip \
    python3 \
    openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o /tmp/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp/ && \
    /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin && \
    rm -rf /tmp/awscliv2.zip /tmp/aws

RUN curl -o /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar xzvf /tmp/docker.tgz && \
    cp docker/* /usr/bin && \
    rm -rf /tmp/docker.tgz ./docker

WORKDIR /root
