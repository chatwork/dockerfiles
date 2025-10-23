provisioners:
  regexpReplace:
    Dockerfile:
      from: "(ARG KONSTRAINT_VERSION=)(\\S+)(\\s*)"
      to: "${1}{{.Dependencies.konstraint.version}}${3}"
    goss/goss.yaml:
      from: '(?m)(.+konstraint --version:\n.*\n\s*stdout:\n\s*-\s*v)([\d\.]+)(\s*)'
      to: '${1}{{.Dependencies.konstraint.version}}${3}'

dependencies:
  konstraint:
    releasesFrom:
      exec:
        command: sh
        args:
        - -c
        - "curl -s https://api.github.com/repos/plexsystems/konstraint/tags | jq -r '.[].name' | sort -V | tr -d 'v'"
    version: "> 0.0.0"
