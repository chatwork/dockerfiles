provisioners:
  textReplace:
    Dockerfile:
      from: "ARG AWSCLI_VERSION={{ .awscli.previousVersion }}"
      to: "ARG AWSCLI_VERSION={{ .awscli.version }}"
    Dockerfile.arm64:
      from: "ARG AWSCLI_VERSION={{ .awscli.previousVersion }}"
      to: "ARG AWSCLI_VERSION={{ .awscli.version }}"

dependencies:
  awscli:
    releasesFrom:
      dockerImageTags:
        source: amazon/aws-cli
    version: "> 2.0.0"
