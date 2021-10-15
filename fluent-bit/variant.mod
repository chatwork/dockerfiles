provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        fluentbit_version: "{{ .fluentbit.version }}"
        fluentbit_cloudwatch_version: "{{ .cloudwatch.version }}"
  textReplace:
    goss/goss.yaml:
      from: "/v{{ .fluentbit.previousVersion }}/"
      to: "/v{{ .fluentbit.version }}/"

dependencies:
  fluentbit:
    releasesFrom:
      dockerImageTags:
        source: fluent/fluent-bit
    version: "> 0.1"
  cloudwatch:
    releasesFrom:
      githubReleases:
        source: aws/amazon-cloudwatch-logs-for-fluent-bit
    version: "> 0.1"
