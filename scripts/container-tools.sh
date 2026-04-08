#!/bin/bash
# Run isolated Syndra tool profiles with Docker or Podman.
# GUI stays on host; only security toolchain runs in container.

set -euo pipefail

PROFILE="${1:-}"
MODE="${2:-run}"
RUNTIME="${SYNDRA_CONTAINER_RUNTIME:-auto}"

if [ -z "$PROFILE" ]; then
    echo "Usage: $0 <blue|red|purple|root> [run|build|shell]"
    exit 1
fi

case "$PROFILE" in
    blue|red|purple|root)
        ;;
    *)
        echo "Invalid profile: $PROFILE"
        exit 1
        ;;
esac

case "$MODE" in
    run|build|shell)
        ;;
    *)
        echo "Invalid mode: $MODE (use run|build|shell)"
        exit 1
        ;;
esac

if [ "$RUNTIME" = "auto" ]; then
    if command -v podman >/dev/null 2>&1; then
        RUNTIME="podman"
    elif command -v docker >/dev/null 2>&1; then
        RUNTIME="docker"
    else
        echo "❌ Neither podman nor docker found."
        exit 1
    fi
fi

if [ "$RUNTIME" != "podman" ] && [ "$RUNTIME" != "docker" ]; then
    echo "❌ Unsupported runtime: $RUNTIME"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
IMAGE_NAME="syndra-tools-${PROFILE}"
DOCKERFILE_PATH="$REPO_DIR/docker/Dockerfile.${PROFILE}"

SHARED_ROOT="${SYNDRA_SHARED_ROOT:-$HOME/.local/share/syndra-tools}"
WORKSPACE_DIR="$SHARED_ROOT/workspace"
REPORTS_DIR="$SHARED_ROOT/reports"
WORDLISTS_DIR="$SHARED_ROOT/wordlists"
LOOT_DIR="$SHARED_ROOT/loot"

mkdir -p "$WORKSPACE_DIR" "$REPORTS_DIR" "$WORDLISTS_DIR" "$LOOT_DIR"

echo "🧱 Building image $IMAGE_NAME with $RUNTIME"
"$RUNTIME" build -f "$DOCKERFILE_PATH" -t "$IMAGE_NAME" "$REPO_DIR"

if [ "$MODE" = "build" ]; then
    echo "✅ Build complete."
    exit 0
fi

RUN_ARGS=(
    --rm
    -it
    --read-only
    --cap-drop=ALL
    --security-opt=no-new-privileges
    --tmpfs /tmp:rw,nosuid,nodev,noexec,size=1g
    --tmpfs /run:rw,nosuid,nodev,noexec,size=64m
    -v "$WORKSPACE_DIR:/workspace"
    -v "$REPORTS_DIR:/reports"
    -v "$WORDLISTS_DIR:/wordlists"
    -v "$LOOT_DIR:/loot"
    -w /workspace
)

if [ "$MODE" = "shell" ]; then
    echo "🚀 Opening isolated shell in $IMAGE_NAME"
    exec "$RUNTIME" run "${RUN_ARGS[@]}" "$IMAGE_NAME" bash
fi

echo "🚀 Running isolated tools container in $IMAGE_NAME"
exec "$RUNTIME" run "${RUN_ARGS[@]}" "$IMAGE_NAME"
