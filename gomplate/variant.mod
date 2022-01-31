provisioners:
  textReplace:
    Dockerfile:
      from: "ARG GOMPLATE_VERSION={{ .gomplate.previousVersion }}"
      to: "ARG GOMPLATE_VERSION={{ .gomplate.version }}"
    Dockerfile.arm64:
      from: "ARG GOMPLATE_VERSION={{ .gomplate.previousVersion }}"
      to: "ARG GOMPLATE_VERSION={{ .gomplate.version }}"
    goss/goss.yaml:
      from: "gomplate version {{ .gomplate.previousVersion }}"
      to: "gomplate version {{ .gomplate.version }}"

dependencies:
  gomplate:
    releasesFrom:
      githubReleases:
        source: hairyhenderson/gomplate
    version: ">= 1.0.0"
