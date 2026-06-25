FROM debian:bookworm-slim

ARG CLAUDE_CODE_VERSION=2.1.193

LABEL version="${CLAUDE_CODE_VERSION}"

# Pure-minimum: only what the Claude Code CLI installer and TLS-based usage
# require. Anything plugin-specific (git, python3, awscli, gh, yq, jq, ...)
# is the extension image's responsibility.
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Non-root user
RUN useradd -m -s /bin/bash claude
USER claude
ENV HOME=/home/claude
ENV PATH="/home/claude/.local/bin:${PATH}"
WORKDIR /home/claude

# Claude Code CLI (Native Install)
RUN curl -fsSL https://claude.ai/install.sh | bash -s "${CLAUDE_CODE_VERSION}"
