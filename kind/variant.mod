provisioners:
  textReplace:
    Dockerfile:
      from: "ARG KIND_VERSION={{ .kind.previousVersion }}"
      to: "ARG KIND_VERSION={{ .kind.version }}"
    goss/goss.yaml:
      from: "- {{ .kind.previousVersion }}"
      to: "- {{ .kind.version }}"

dependencies:
  kind:
    releasesFrom:
      githubReleases:
        source: kubernetes-sigs/kind
    version: "> 1.0"
