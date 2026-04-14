FROM debian:bookworm-slim

ARG CLAUDE_CODE_VERSION=latest

LABEL version="${CLAUDE_CODE_VERSION}"

# Common dependencies + debugging tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Claude Code CLI install requirement
    curl \
    ca-certificates \
    # Plugin common dependencies
    git \
    jq \
    unzip \
    python3 \
    python3-pip \
    awscli \
    # Shell / container debugging
    bash \
    less \
    procps \
    net-tools \
    dnsutils \
    iputils-ping \
    vim-tiny \
    strace \
    && rm -rf /var/lib/apt/lists/*

# Claude Code CLI (Native Install)
ENV PATH="/root/.local/bin:${PATH}"
RUN curl -fsSL https://claude.ai/install.sh | bash

# yq
ARG YQ_VERSION=4.44.6
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_$(dpkg --print-architecture)" \
      -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
