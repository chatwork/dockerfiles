provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kfo_version: "v{{ .kfo.version }}"
        fluentd_version: "v{{ .fluentd.version }}"
    goss/goss.yaml:
      source: goss.yaml.tpl
      arguments:
        fluentd_version: "{{ .fluentd.version }}"
  textReplace:
    Makefile:
      from: "v{{ .kfo.previousVersion }}"
      to: "v{{ .kfo.version }}"
dependencies:
  kfo:
    releasesFrom:
      githubReleases:
        source: vmware/kube-fluentd-operator
    version: "> v1.9.0"
  fluentd:
    releasesFrom:
      githubTags:
        source: fluent/fluentd
    version: "~ v1.9.0"
