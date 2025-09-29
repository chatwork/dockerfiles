provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        mysql_version: "{{ .mysql.version }}"
        awscli_version: "{{ .awscli.version }}"
    goss/goss.yaml:
      source: goss/goss.yaml.tpl
      arguments:
        mysql_version: "{{ .mysql.version }}"
        awscli_version: "{{ .awscli.version }}"

dependencies:
  mysql:
    releasesFrom:
      validVersionPattern: "[0-9]+\\.[0-9]+\\.[0-9]+-debian"
      dockerImageTags:
        source: _/mysql
    version: "~ 8.0.0"
  awscli:
    releasesFrom:
      dockerImageTags:
        source: chatwork/aws
    version: "> 2.0.0"
