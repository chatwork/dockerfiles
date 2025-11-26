provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
        kubectl_version: "{{ .kubectl.version }}"

dependencies:
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "3.19.2"
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
