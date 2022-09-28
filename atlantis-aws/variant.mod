provisioners:
  textReplace:
    Dockerfile:
      from: "ARG ATLANTIS_VERSION={{ .atlantis.previousVersion }}"
      to: "ARG ATLANTIS_VERSION={{ .atlantis.version }}"
    goss/goss.yaml:
      from: "- {{ .atlantis.previousVersion }}"
      to: "- {{ .atlantis.version }}"

dependencies:
  atlantis:
    releasesFrom:
      githubReleases:
        source: runatlantis/atlantis
    version: "> 0.0.0"
