provisioners:
  textReplace:
    Dockerfile:
      from: "ARG ENVSUBST_VERSION={{ .envsubst.previousVersion }}"
      to: "ARG ENVSUBST_VERSION={{ .envsubst.version }}"

dependencies:
  envsubst:
    releasesFrom:
      githubReleases:
        source: a8m/envsubst
    version: ">= 1.0.0"
