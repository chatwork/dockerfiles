FROM adoptopenjdk:8-jdk-hotspot-bionic

ARG MYSQL_VERSION=5.7.36
ARG FLYWAY_VERSION=3.1

LABEL version="${FLYWAY_VERSION}-${MYSQL_VERSION}"
LABEL flyway_version="${FLYWAY_VERSION}"
LABEL mysql_version="${MYSQL_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN apt-get update \
    && apt-get install -y \
        mysql-client-5.7=${MYSQL_VERSION}-0ubuntu0.18.04.1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV FLYWAY_DOWNLOAD_URL=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz

ENV PATH=${PATH}:/opt/flyway

WORKDIR /opt
RUN curl -o flyway-command.tar.gz ${FLYWAY_DOWNLOAD_URL} \
    && tar xvf flyway-command.tar.gz \
    && mv flyway-${FLYWAY_VERSION} flyway \
    && rm flyway-command.tar.gz \
    && chmod a+x /opt/flyway/flyway

ENTRYPOINT ['/opt/flyway/flyway']
