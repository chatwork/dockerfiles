FROM openjdk:8u212-jdk-alpine

ARG AWS_VERSION=2.2.13
ARG GATLING_VERSION=3.4.1

LABEL version="0.1.1-gatling$GATLING_VERSION"
LABEL maintainer="katsuno@chatwork.com"

WORKDIR /opt

# install gatling
RUN mkdir -p gatling && \
  mkdir -p work && \
  apk add --update wget bash libc6-compat && \
  mkdir -p /tmp/downloads && \
  wget -q -O /tmp/downloads/gatling-$GATLING_VERSION.zip \
  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/ && \
  rm -rf /tmp/*

# install aws cli to /usr/local/bin/aws
RUN wget -q -O awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip  \
  && unzip -q awscliv2.zip \
  && ./aws/install \
  && rm awscliv2.zip

# change context to gatling directory
WORKDIR  /opt/work

ENV GATLING_HOME /opt/gatling

COPY generate-report.sh /generate-report.sh

ENTRYPOINT ["/generate-report.sh"]
