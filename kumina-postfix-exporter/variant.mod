provisioners:
  textReplace:
    Dockerfile:
      from: "ARG POSTFIX_EXPORTER_VERSION={{ .variant.previousVersion }}"
      to: "ARG POSTFIX_EXPORTER_VERSION={{ .variant.version }}"

dependencies:
  variant:
    releasesFrom:
      githubReleases:
        source: kumina/postfix_exporter
    version: "> 0.1"
