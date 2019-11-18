provisioners:
  textReplace:
    Dockerfile:
      from: "ARG HELMFILE_VERSION={{ .helmfile.previousVersion }}"
      to: "ARG HELMFILE_VERSION={{ .helmfile.version }}"

dependencies:
  helmfile:
    releasesFrom:
      jsonPath:
        source: https://quay.io/api/v1/repository/roboll/helmfile/tag/
        versions: "$.tags[*].name"
    version: "> 0.1"
