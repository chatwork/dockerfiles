provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        kfo_version: "{{ .kfo.version }}"
        fluentd_version: "{{ .fluentd.version }}"
  textReplace:
    Makefile:
      from: "{{ .kfo.previousVersion }}"
      to: "{{ .kfo.version }}"

dependencies:
  kfo:
    releasesFrom:
      githubReleases:
        source: vmware/kube-fluentd-operator
    version: "> 1.9.0"
  fluentd:
    releasesFrom:
      githubTags:
        source: fluent/fluentd
    version: "> 1.6.0"
