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
      from: |
        # {{`{{ .kubectl_version }}`}}
        {{ .kubectl.previousVersion }}
      to: |
        # {{`{{ .kubectl_version }}`}}
        {{ .kubectl.version }}
        {{ .kubectl.previousVersion }}
    helm-versions:
      from: |
        # {{`{{ .helm_version }}`}}
        {{ .helm.previousVersion }}
      to: |
        # {{`{{ .helm_version }}`}}
        {{ .helm.version }}
        {{ .helm.previousVersion }}
    helmfile-versions:
      from: |
        # {{`{{ .helmfile_version }}`}}
        {{ .helmfile.previousVersion }}
      to: |
        # {{`{{ .helmfile_version }}`}}
        {{ .helmfile.version }}
        {{ .helmfile.previousVersion }}

dependencies:
  kubectl:
    releasesFrom:
      exec:
        command: curl
        args:
        - -s
        - 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    version: "> 1.0"
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
  helmfile:
    releasesFrom:
      githubReleases:
        source: roboll/helmfile
    version: "> 0.1"
