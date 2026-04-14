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
        command: curl
        args:
        - -s
        - 'https://registry.npmjs.org/@anthropic-ai/claude-code'
        jsonPath: $.versions.*.version
    version: "> 2.0"
