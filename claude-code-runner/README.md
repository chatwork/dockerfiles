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

- Claude Code CLI
- curl, ca-certificates, git, jq, yq, unzip
- python3, python3-pip, awscli
- gh (GitHub CLI)
- Debugging tools (bash, less, procps, net-tools, dnsutils, vim-tiny, strace)
