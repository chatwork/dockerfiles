provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        helm_version: "{{ .helm.version }}"
        helmfile_version: "{{ .helmfile.version }}"

dependencies:
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
