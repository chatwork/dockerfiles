provisioners:
  textReplace:
    Dockerfile:
      from: "ARG GOSS_VERSION={{ .goss.previousVersion }}"
      to: "ARG GOSS_VERSION={{ .goss.version }}"
    Dockerfile.arm64v8:
      from: "ARG GOSS_VERSION={{ .goss.previousVersion }}"
      to: "ARG GOSS_VERSION={{ .goss.version }}"

dependencies:
  goss:
    releasesFrom:
      githubReleases:
        source: aelsabbahy/goss
    version: "> 0.3.15"
