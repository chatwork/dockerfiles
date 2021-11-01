FROM adoptopenjdk:8-jdk-hotspot-bionic

LABEL version="1.0.0"
LABEL maintainer="shinohara@chatwork.com"

RUN apt-get update \
    && apt-get install -y \
        mysql-client-5.7

ARG FLYWAY_VERSION=3.1
ENV FLYWAY_DOWNLOAD_URL=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz

ENV PATH=${PATH}:/opt/flyway

WORKDIR /opt
RUN curl -o flyway-command.tar.gz ${FLYWAY_DOWNLOAD_URL} \
    && tar xvf flyway-command.tar.gz \
    && mv flyway-${FLYWAY_VERSION} flyway \
    && rm flyway-command.tar.gz \
    && chmod a+x /opt/flyway/flyway

ENTRYPOINT ['flyway']
