file:
  /usr/local/bin/helmfile:
    exists: true
    mode: "0755"
  /usr/local/bin/helm:
    exists: true
    mode: "0755"
  /usr/local/bin/kubectl:
    exists: true
    mode: "0755"
  /usr/local/bin/yq:
    exists: true
    mode: "0755"
command:
  /usr/local/bin/helm version:
    exit-status: 0
    stdout:
      - "{{ .helm_version }}"
  /usr/local/bin/helmfile -v:
    exit-status: 0
    stdout:
      - "{{ .helmfile_version }}"
  /usr/local/bin/helm plugin list:
    exit-status: 0
    stdout:
      - /^diff/
      - /^helm-git/
      - /^secrets/
  /usr/local/bin/yq --version:
    exit-status: 0
  /usr/local/bin/kubectl version --client:
    exit-status: 0
  # CVE-2026-109518: the image must ship the fixed APT
  dpkg --compare-versions "$(dpkg-query -W -f='${Version}' apt)" ge 2.4.15ubuntu0.1:
    exit-status: 0
