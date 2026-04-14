# claude-code

A base Docker image for running [Claude Code](https://claude.ai/code) in containers. Provides the Claude Code CLI and common dependencies pre-installed.

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

| Category | Tools |
|---|---|
| Core | Claude Code CLI, curl, ca-certificates, git, bash, less |
| Data processing | jq, yq, unzip |
| Cloud / CI | awscli, gh (GitHub CLI), python3 |
| Security | gpg, openssh-client |

## Version management

Claude Code CLI version is pinned and automatically updated via [variant mod](https://github.com/variantdev/mod). See `variant.mod` and `variant.lock` for details.
