provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        fluentd_version: '{{ splitList "-" .fluentd.version | first }}'
        fluentd_image_version: '{{ .fluentd.version }}'
  textReplace:
    goss/goss.yaml:
      from: 'fluentd {{ splitList "-" .fluentd.previousVersion | first }}'
      to: 'fluentd {{ splitList "-" .fluentd.version | first }}'
dependencies:
  fluentd:
    releasesFrom:
      validVersionPattern: "[0-9]+\\.[0-9]+\\.[0-9]+-debian-[0-9.]+"
      dockerImageTags:
        source: fluent/fluentd
    version: "~ 1.17.0-debian-1.0"
