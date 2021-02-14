provisioners:
  textReplace:
    Dockerfile:
      from: "ARG OPENAPI2JSONSCHEMA_VERSION={{ .variant.previousVersion }}"
      to: "ARG OPENAPI2JSONSCHEMA_VERSION={{ .variant.version }}"

dependencies:
  variant:
    releasesFrom:
      exec:
        command: sh
        args:
          - -c
          - |
            curl -sSL https://pypi.org/rss/project/openapi2jsonschema/releases.xml | grep title | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+'
    version: "> 0.1.0"
