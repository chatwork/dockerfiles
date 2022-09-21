provisioners:
  textReplace:
    Dockerfile:
      from: "ARG CONFTEST_VERSION={{ .conftest.previousVersion }}"
      to: "ARG CONFTEST_VERSION={{ .conftest.version }}"
    goss/goss.yaml:
      from: "- {{ .conftest.previousVersion }}"
      to: "- {{ .conftest.version }}"

dependencies:
  conftest:
    releasesFrom:
      githubReleases:
        source: open-policy-agent/conftest
    version: "> 0.0.0"
