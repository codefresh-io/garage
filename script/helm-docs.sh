#!/bin/bash
## Reference: https://github.com/norwoodj/helm-docs
set -eux
CHART_DIR="$(cd "$(dirname "$0")/helm/garage" && pwd)"
echo "$CHART_DIR"

echo "Running Helm-Docs"
docker run \
    -v "$CHART_DIR:/helm-docs" \
    -u $(id -u) \
    --rm \
    jnorwood/helm-docs:v1.9.1
