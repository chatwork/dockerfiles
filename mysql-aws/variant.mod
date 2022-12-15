provisioners:
  textReplace:
    Dockerfile:
      from: "FROM mysql:{{ .mysql.previousVersion }}-debian"
      to: "FROM mysql:{{ .mysql.version }}-debian"

dependencies:
  mysql:
    releasesFrom:
      dockerImageTags:
        source: library/mysql
    version: "~ 5.7"
    validVersionPattern: "[5]+\\.[7]+\\.[0-9]+"