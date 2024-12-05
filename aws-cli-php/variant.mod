provisioners:
  textReplace:
    Dockerfile:
      from: "ARG AWS_CLI_VERSION={{ .awscli.previousVersion }}"
      to: "ARG AWS_CLI_VERSION={{ .awscli.version }}"
    Dockerfile.arm64:
      from: "ARG AWS_CLI_VERSION={{ .awscli.previousVersion }}"
      to: "ARG AWS_CLI_VERSION={{ .awscli.version }}"
    goss/goss.yaml:
      from: "- {{ .awscli.previousVersion }}"
      to: "- {{ .awscli.version }}"

dependencies:
  aws-cli:
    releasesFrom:
      dockerImageTags:
        source: amazon/aws-cli
        version: "> 2.3.5"
