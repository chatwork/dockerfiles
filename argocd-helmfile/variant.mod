provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"

dependencies:
  argocd:
    releasesFrom:
      githubReleases:
        source: argoproj/argo-cd
    version: "> 1.5.0"
  helmfile:
    releasesFrom:
      jsonPath:
        source: https://quay.io/api/v1/repository/roboll/helmfile/tag/
        versions: "$.tags[*].name"
    version: "> 0.1"
  kubectl:
    releasesFrom:
      githubReleases:
        source: kubernetes/kubernetes
    version: "~ 1.17"


