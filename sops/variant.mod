provisioners:
  textReplace:
    Dockerfile:
      from: "ARG SOPS_VERSION={{ .sops.previousVersion }}"
      to: "ARG SOPS_VERSION={{ .sops.version }}"

dependencies:
  sops:
    releasesFrom:
      githubReleases:
        source: mozilla/sops
    version: "> 3.3.1"
