provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kafka_connect_version: "{{ .kackaConnect.version }}"
        mysql_connector_version: "{{ .mysqlConnector.version }}"

dependencies:
  kackaConnect:
    releasesFrom:
      dockerImageTags:
        source: confluentinc/cp-kafka-connect-base
    version: "< 6.1.0"
  mysqlConnector:
    releasesFrom:
      exec:
        command: sh
        args:
          - -c
          - |
            curl -sSL https://repo1.maven.org/maven2/mysql/mysql-connector-java/ | grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+" | sort | uniq
    version: "> 0.1.0"
