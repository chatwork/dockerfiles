provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kubectl_version: "{{ .kubectl.previousVersion }}"
  textReplace:
    goss/goss.yaml:
      from: "- v{{ .kubectl.previousVersion }}"
      to: "- v{{ .kubectl.version }}"

dependencies:
  kubectl:
    releasesFrom:
      exec:
        command: curl
        args:
        - -s
        - 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    version: "> 1.0"
