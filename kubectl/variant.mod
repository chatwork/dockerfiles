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
      exec:
        command: curl
        args:
        - -s
        - 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    version: "> 1.0"
