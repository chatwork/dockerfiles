FROM ubuntu:18.04 as builder

WORKDIR /opt

## https://downloads.mysql.com/archives/get/p/23/file/mysql-5.6.51.tar.gz
ARG MYSQL_VERSION=5.6.51
ENV MYSQL_DOWNLOAD_URL=https://downloads.mysql.com/archives/get/p/23/file/mysql-${MYSQL_VERSION}.tar.gz

RUN groupadd mysql \
    && useradd -g mysql -s /usr/sbin/nologin mysql \
    && apt-get update \
    && apt-get install -y \
        bison \
        cmake \
        curl \
        git \
        g++ \
        libncurses5-dev \
        libssl-dev \
        ninja-build \
        make

RUN curl -OL ${MYSQL_DOWNLOAD_URL} \
    && tar xvf mysql-${MYSQL_VERSION}.tar.gz \
    && rm mysql-${MYSQL_VERSION}.tar.gz

WORKDIR /opt/mysql-${MYSQL_VERSION}

RUN cmake -GNinja \
      -DDEFAULT_CHARSET=utf8 \
      -DDEFAULT_COLLATION=utf8_general_ci \
      -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    && ninja \
    && ninja install

#--------------------------------------------------
FROM adoptopenjdk:8-jdk-hotspot-bionic

LABEL version="1.0.0"
LABEL maintainer="shinohara@chatwork.com"

COPY --from=builder /usr/local/mysql/bin /usr/local/bin

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
