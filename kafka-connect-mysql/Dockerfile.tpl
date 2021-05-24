ARG KAFKA_CONNECT_VERSION={{ .kafka_connect_version }}

# https://github.com/confluentinc/cp-docker-images/blob/5.3.1-post/debian/kafka-connect-base/Dockerfile
FROM confluentinc/cp-kafka-connect-base:${KAFKA_CONNECT_VERSION}

ARG KAFKA_CONNECT_VERSION={{ .kafka_connect_version }}
ARG MYSQL_CONNECTOR_VERSION={{ .mysql_connector_version }}

LABEL version="${KAFKA_CONNECT_VERSION}-${MYSQL_CONNECTOR_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="murakami@chatwork.com"

RUN wget -qO - http://packages.confluent.io/deb/$(echo $KAFKA_CONNECT_VERSION | sed 's/\.[0-9]*$//')/archive.key | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
        confluent-kafka-connect-jdbc=${KAFKA_CONNECT_VERSION}-1 \
    && wget -O /usr/share/java/kafka/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar \
    && mv /usr/share/java/kafka-connect-jdbc/* /usr/share/java/kafka/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8083
