provisioners:
  textReplace:
    Dockerfile:
      from: "ARG KONSTRAINT_VERSION={{ .konstraint.previousVersion }}"
      to: "ARG KONSTRAINT_VERSION={{ .konstraint.version }}"
    goss/goss.yaml:
      from: "- v{{ .konstraint.previousVersion }}"
      to: "- v{{ .konstraint.version }}"

dependencies:
  konstraint:
    releasesFrom:
      githubTags:
        source: plexsystems/konstraint
    version: "> 0.41.0"
