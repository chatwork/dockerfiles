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
  helmfile:
    releasesFrom:
      githubReleases:
        source: helmfile/helmfile
    version: "1.1.5" # helmfileV1以降のため、一旦versionを固定する
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "3.19.2" # helmfileV1以降のため、一旦versionを固定する
