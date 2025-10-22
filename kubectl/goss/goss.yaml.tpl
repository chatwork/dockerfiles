file:
  /usr/local/bin/kubectl:
    exists: true
    mode: "0711"
command:
  /usr/local/bin/kubectl version --client=true:
    exit-status: 0
