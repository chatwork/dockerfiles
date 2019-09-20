provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        git:
          version: "{{ .git.version }}"
        mod:
          version: "{{ .mod.version }}"

dependencies:
  git:
    releasesFrom:
      dockerImageTags:
        source: alpine/git
      version: "> 1.0.6"
  mod:
    releasesFrom:
      githubReleases:
        source: variantdev/mod
