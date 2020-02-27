provisioners:
  textReplace:
    Dockerfile:
      from: "ARG AWSCLI_VERSION={{ .awscli.previousVersion }}"
      to: "ARG AWSCLI_VERSION={{ .awscli.version }}"

dependencies:
  awscli:
    releasesFrom:
      githubTags:
        source: aws/aws-cli
    version: "> 2.0.0"
