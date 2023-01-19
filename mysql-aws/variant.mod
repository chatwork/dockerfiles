provisioners:
  textReplace:
    Dockerfile:
      from: "ARG MYSQL_VERSION={{ .mysql.previousVersion }}"
      to: "ARG MYSQL_VERSION={{ .mysql.version }}"

dependencies:
  mysql:
    releasesFrom:
      dockerImageTags:
        source: library/mysql
    version: "~ 5.7"
    validVersionPattern: "[5]+\\.[7]+\\.[0-9]+"