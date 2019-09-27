provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kubectl_version: "{{ .kubectl.version }}"
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
  textReplace:
    kubectl-versions:
      from: "# {{`{{ .kubectl_version }}`}}"
      to: |
        # {{`{{ .kubectl_version }}`}}
        {{ .kubectl.version }}
    helm-versions:
      from: "# {{`{{ .helm_version }}`}}"
      to: |
        # {{`{{ .helm_version }}`}}
        {{ .helm.version }}
    helmfile-versions:
      from: "# {{`{{ .helmfile_version }}`}}"
      to: |
        # {{`{{ .helmfile_version }}`}}
        {{ .helmfile.version }}

dependencies:
  kubectl:
    releasesFrom:
      exec:
        command: curl
        args:
        - -s
        - 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
  helmfile:
    releasesFrom:
      githubReleases:
        source: roboll/helmfile
    version: "> 1.14"
