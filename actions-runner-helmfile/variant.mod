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
      validVersionPattern: "[0-9]+\\.[0-9]+\\.[0-9]+-ubuntu-22.04+"
      dockerImageTags:
        source: summerwind/actions-runner
    version: "~ 2.309.0-ubuntu-22.04-ead26ab"
