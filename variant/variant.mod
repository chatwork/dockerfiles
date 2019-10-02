provisioners:
  textReplace:
    Dockerfile:
      from: "ARG VARIANT_VERSION={{ .variant.previousVersion }}"
      to: "ARG VARIANT_VERSION={{ .variant.version }}"

dependencies:
  variant:
    releasesFrom:
      githubReleases:
        source: mumoshu/variant
    version: "> 0.1"
