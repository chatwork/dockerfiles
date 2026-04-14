#!/bin/bash
set -euo pipefail

# Default entrypoint: show Claude Code version.
# Override by mounting your own /entrypoint.sh or using a derived image.
echo "=== claude-code-runner ==="
claude --version
