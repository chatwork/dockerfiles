provisioners:
  textReplace:
    Dockerfile:
      from: "ARG EKSCTL_VERSION={{ .eksctl.previousVersion }}"
      to: "ARG EKSCTL_VERSION={{ .eksctl.version }}"
    Dockerfile.arm64:
      from: "ARG EKSCTL_VERSION={{ .eksctl.previousVersion }}"
      to: "ARG EKSCTL_VERSION={{ .eksctl.version }}"
    goss/goss.yaml:
      from: "- {{ .eksctl.previousVersion }}"
      to: "- {{ .eksctl.version }}"

dependencies:
  eksctl:
    releasesFrom:
      githubReleases:
        source: weaveworks/eksctl
    version: "> 0.10.2"
