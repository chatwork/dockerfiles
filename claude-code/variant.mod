provisioners:
  textReplace:
    Dockerfile:
      from: "ARG CLAUDE_CODE_VERSION={{ .claude_code.previousVersion }}"
      to: "ARG CLAUDE_CODE_VERSION={{ .claude_code.version }}"
    goss/goss.yaml:
      from: "- {{ .claude_code.previousVersion }}"
      to: "- {{ .claude_code.version }}"

dependencies:
  claude_code:
    releasesFrom:
      exec:
        command: bash
        args:
        - -c
        - "curl -s https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/latest"
    version: "> 2.0"
