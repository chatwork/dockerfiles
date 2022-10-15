provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kafka_connect_version: "{{ .kackaConnect.version }}"

dependencies:
  kackaConnect:
    releasesFrom:
      dockerImageTags:
        source: confluentinc/cp-kafka-connect-base
    version: "< 6.2.0"
