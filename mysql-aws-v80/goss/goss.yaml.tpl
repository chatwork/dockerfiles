file:
  /usr/local/bin/aws:
    exists: true
  /usr/bin/mysql:
    exists: true
  /usr/bin/awk:
    exists: true
  /bin/date:
    exists: true
  /bin/echo:
    exists: true
  /bin/grep:
    exists: true
  /bin/egrep:
    exists: true
  /usr/bin/jq:
    exists: true
  /bin/sed:
    exists: true
  /usr/local/bin/vault:
    exists: true
command:
  /usr/bin/mysql --version:
    exit-status: 0
    stdout:
      - {{ .mysql_version }}
  /usr/local/bin/aws --version:
    exit-status: 0
    stdout:
      - {{ .awscli_version }}
