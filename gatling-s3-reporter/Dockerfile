FROM openjdk:8u212-jdk-alpine

ARG AWS_VERSION=1.16.58
ARG GATLING_VERSION=3.4.1

LABEL version="0.0.1-gatling$GATLING_VERSION"
LABEL maintainer="katsuno@chatwork.com"

RUN apk --no-cache add py3-pip jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli==${AWS_VERSION}

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

# change context to gatling directory
WORKDIR  /opt/work

ENV GATLING_HOME /opt/gatling

COPY generate-report.sh /generate-report.sh

ENTRYPOINT ["/generate-report.sh"]

