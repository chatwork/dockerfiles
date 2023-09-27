provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        runner_version: "{{ .runner.version }}"
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
    version: "> 0.1"
  helm:
    releasesFrom:
      githubReleases:
        source: helm/helm
    version: "> 1.0"
  runner:
    releasesFrom:
      githubReleases:
        source: actions/runner
    version: "> 0.1"
