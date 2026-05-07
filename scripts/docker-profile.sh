#!/bin/bash
# Build and run an isolated Syndra profile container.

set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <blue|red|purple|root> [--build-only]"
    exit 1
fi

PROFILE="$1"
MODE="${2:-run}"

case "$PROFILE" in
    blue|red|purple|root)
        ;;
    *)
        echo "Invalid profile: $PROFILE"
        echo "Allowed values: blue, red, purple, root"
        exit 1
        ;;
esac

if [ "$MODE" != "run" ] && [ "$MODE" != "--build-only" ]; then
    echo "Invalid option: $MODE"
    echo "Use --build-only or omit it."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
IMAGE_NAME="syndra-${PROFILE}"
DOCKERFILE_PATH="$REPO_DIR/docker/Dockerfile.${PROFILE}"

if [ ! -f "$DOCKERFILE_PATH" ]; then
    echo "Dockerfile not found: $DOCKERFILE_PATH"
    exit 1
fi

echo "Building $IMAGE_NAME from $DOCKERFILE_PATH"
docker build -f "$DOCKERFILE_PATH" -t "$IMAGE_NAME" "$REPO_DIR"

if [ "$MODE" = "--build-only" ]; then
    echo "Build complete."
    exit 0
fi

echo "Starting isolated container $IMAGE_NAME"
docker run --rm -it -v "$REPO_DIR:/workspace" "$IMAGE_NAME"
