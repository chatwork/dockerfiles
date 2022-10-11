file:
  /usr/local/bin/aws:
    exists: true
    mode: "0777"
  /usr/local/bin/terraform:
    exists: true
    mode: "0777"
  /usr/local/bin/atlantis:
    exists: true
    mode: "0755"
  /usr/bin/conftest:
    exists: true
    mode: "0755"
command:
  /usr/local/bin/aws --version:
    exit-status: 0
    stdout:
      - {{ .awscli_version }}
  /usr/bin/conftest --version:
    exit-status: 0
    stdout:
      - {{ .conftest_version }}
  /usr/local/bin/terraform --version:
    exit-status: 0
    stdout:
      - {{ .terraform_version }}
  /usr/local/bin/atlantis version:
    exit-status: 0
    stdout:
      - {{ .atlantis_version }}
