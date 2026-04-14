# claude-code-runner

A base Docker image for running [Claude Code](https://claude.ai/code) in containers. Provides the Claude Code CLI and common dependencies pre-installed.

This image is designed to be used as a base (`FROM chatwork/claude-code-runner`) by teams building their own plugin marketplace runner images.

## Usage

### As a base image

```dockerfile
FROM chatwork/claude-code-runner:latest

# Copy your marketplace plugins
COPY . /marketplace
RUN claude plugin marketplace add /marketplace

# (Optional) Override entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
```

### Standalone

```
$ docker run chatwork/claude-code-runner
```

## Included

| Category | Tools |
|---|---|
| Core | Claude Code CLI, curl, ca-certificates, git, bash, less |
| Data processing | jq, yq, unzip |
| Cloud / CI | awscli, gh (GitHub CLI), python3 |
| Security | gpg, openssh-client |

## Version management

Claude Code CLI version is pinned and automatically updated via [variant mod](https://github.com/mumoshu/variant). See `variant.mod` and `variant.lock` for details.
