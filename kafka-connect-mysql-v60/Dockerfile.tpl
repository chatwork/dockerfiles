ARG KAFKA_CONNECT_VERSION={{ .kafka_connect_version }}

FROM confluentinc/cp-kafka-connect-base:${KAFKA_CONNECT_VERSION}

ARG KAFKA_CONNECT_VERSION={{ .kafka_connect_version }}
ARG MYSQL_CONNECTOR_VERSION={{ .mysql_connector_version }}

LABEL version="${KAFKA_CONNECT_VERSION}-${MYSQL_CONNECTOR_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="murakami@chatwork.com"

USER root

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.0 \
    && wget -O /usr/share/java/kafka/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar

USER appuser

EXPOSE 8083
