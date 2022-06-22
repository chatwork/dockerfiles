provisioners:
  textReplace:
    Dockerfile:
      from: "ARG HELM_VERSION={{ .helm.previousVersion }}"
      to: "ARG HELM_VERSION={{ .helm.version }}"
    goss/goss.yaml:
      from: "- {{ .helm.previousVersion }}"
      to: "- {{ .helm.version }}"

dependencies:
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
