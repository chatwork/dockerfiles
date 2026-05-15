# claude-code

A base Docker image for running [Claude Code](https://claude.ai/code) in containers. Provides only the Claude Code CLI and the minimum TLS-capable runtime; anything plugin-specific is the extension image's responsibility.

This image is designed to be used as a base (`FROM chatwork/claude-code`) by teams building their own plugin marketplace runner images, or directly in Kubernetes CronJobs.

## Usage

### As a base image

```dockerfile
FROM chatwork/claude-code:latest

# Copy your marketplace plugins
COPY . /marketplace
RUN claude plugin marketplace add /marketplace
```

### In a Kubernetes CronJob

```yaml
containers:
  - name: task
    image: chatwork/claude-code:latest
    command: ["/bin/bash", "-lc"]
    args:
      - |
        set -euo pipefail
        claude --print "Generate weekly report"
```

### Standalone

```
$ docker run --rm chatwork/claude-code claude --version
```

## Included

- Claude Code CLI (Native Install) under `/home/claude/.local/bin/claude`
- `curl`, `ca-certificates`, `bash` — required by the installer and TLS-based runtime usage

That's it. Plugin-specific tooling (`git`, `python3`, `jq`, `yq`, `gh`, `awscli`, ...) is intentionally **not** bundled here; extension images install what they need.

## Version management

Claude Code CLI version is pinned and automatically updated via [variant mod](https://github.com/variantdev/mod). See `variant.mod` and `variant.lock` for details.
