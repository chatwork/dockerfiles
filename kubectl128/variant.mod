provisioners:
  textReplace:
    Dockerfile:
      from: "ARG KUBECTL_VERSION={{ .kubectl.previousVersion }}"
      to: "ARG KUBECTL_VERSION={{ .kubectl.version }}"
    goss/goss.yaml:
      from: "- v{{ .kubectl.previousVersion }}"
      to: "- v{{ .kubectl.version }}"

dependencies:
  kubectl:
    releasesFrom:
      githubReleases:
        source: kubernetes/kubernetes
    version: "~ 1.28"
