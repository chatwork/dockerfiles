command:
  /usr/local/bin/sops -v:
    exit-status: 0
  /usr/local/bin/argocd version:
    exit-status: 1
    stdout:
    - {{ .argocd_version }}
  /usr/local/bin/kubectl version:
    exit-status: 1
    stdout:
    - 1.28.7
  /usr/local/bin/helm plugin list:
    exit-status: 0
    stdout:
      - /^diff/
      - /^helm-git/
      - /^secrets/
  /usr/local/bin/helm version:
    exit-status: 0
    stdout:
      - {{ .helm_version }}
  /usr/local/bin/helmfile -v:
    exit-status: 0
    stdout:
      - {{ .helmfile_version }}
