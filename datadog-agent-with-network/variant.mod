provisioners:
  textReplace:
    Dockerfile:
      from: "ARG DATADOG_VERSION={{ .datadog.previousVersion }}"
      to: "ARG DATADOG_VERSION={{ .datadog.version }}"
    goss/goss.yaml:
      from: "- {{ .datadog.previousVersion }}"
      to: "- {{ .datadog.version }}"

dependencies:
  datadog:
    releasesFrom:
      dockerImageTags:
        source: datadog/agent
    version: "> 1.0"
