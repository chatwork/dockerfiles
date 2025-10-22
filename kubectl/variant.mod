provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kubectl_version: "{{ .kubectl.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        kubectl_version: "{{ .kubectl.version }}"

dependencies:
  kubectl:
    releasesFrom:
      exec:
        command: curl
        args:
        - -s
        - 'https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    version: "> 1.0"
