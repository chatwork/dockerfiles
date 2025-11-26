provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        argocd_version: "{{ .argocd.version }}"
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"

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
  helmfile:  
    releasesFrom:  
      githubReleases:
        source: helmfile/helmfile
    version: "< 1.0"
  kubectl:
    releasesFrom:
      exec:
        command: curl
        args:
        - -s
        - 'https://cdn.dl.k8s.io/release/stable.txt'
    version: "> 1.0"
