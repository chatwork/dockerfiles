provisioners:
  textReplace:
    Dockerfile:
      from: "ARG FLUENTD_VERSION=\"{{ .fluentd.previousVersion }}\""
      to: "ARG FLUENTD_VERSION=\"{{ .fluentd.version }}\""
    goss/goss.yaml:
      from: "fluentd {{ splitList "-" .fluentd.version | first }}"
      to: "fluentd {{ splitList "-" .fluentd.previousVersion | first }}"
dependencies:
  fluentd:
    releasesFrom:
      validVersionPattern: "[0-9]\\.[0-9]\\.[0-9]-debian-[0-9.]+"
      dockerImageTags:
        source: fluent/fluentd
    version: "> 1.10.0-debian-1.0"
