FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u181-b13

ARG SCALA_VERSION=2.12.4
ARG SBT_VERSION=1.1.0
ARG WORKDIR=/root

LABEL version="x86_64-ubuntu-jdk8u181-b13-$SCALA_VERSION-$SBT_VERSION"
LABEL maintainer="Tomoyoshi Ogura <ogura@chatwork.com>"

ENV LANG=C.UTF-8
ENV PATH=$WORKDIR/scala-$SCALA_VERSION/bin:$PATH

RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
    curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update && \
    apt-get install -y \
    sbt \
    libaio1 \
    git \
    openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sbt sbtVersion

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD ./cacerts /opt/java/openjdk/jre/lib/security/cacerts

WORKDIR $WORKDIR
