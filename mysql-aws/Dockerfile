ARG MYSQL_VERSION=5.7.42

FROM mysql:${MYSQL_VERSION}-debian

ARG MYSQL_VERSION=5.7.42
LABEL version="${MYSQL_VERSION}"
LABEL maintainer="keisuke.furuya@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y curl jq unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install