provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"

dependencies:
  argocd:
    releasesFrom:
      githubReleases:
        source: argoproj/argo-cd
    version: "> 1.5.0"
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
