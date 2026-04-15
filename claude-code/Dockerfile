FROM debian:bookworm-slim

ARG CLAUDE_CODE_VERSION=2.1.109

LABEL version="${CLAUDE_CODE_VERSION}"

# Common dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    jq \
    unzip \
    python3 \
    awscli \
    gpg \
    openssh-client \
    bash \
    less \
    && rm -rf /var/lib/apt/lists/*

# yq (latest)
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$(dpkg --print-architecture)" \
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

# Non-root user
RUN useradd -m -s /bin/bash claude
USER claude
ENV HOME=/home/claude
ENV PATH="/home/claude/.local/bin:${PATH}"
WORKDIR /home/claude

# Claude Code CLI (Native Install)
RUN curl -fsSL https://claude.ai/install.sh | bash -s "${CLAUDE_CODE_VERSION}"
