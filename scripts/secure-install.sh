#!/bin/bash
# Secure install entrypoint: clone/update repo, verify integrity, run selected installer.

set -euo pipefail

PROFILE="${1:-interactive}"
INSTALL_DIR="${SYNDRA_INSTALL_DIR:-$HOME/.config/SyndraShell}"
REPO_URL="https://github.com/Fud0o0/Syndra.git"

case "$PROFILE" in
    interactive|blue|red|purple|root|base)
        ;;
    *)
        echo "Usage: $0 [interactive|base|blue|red|purple|root]"
        exit 1
        ;;
esac

if ! command -v git >/dev/null 2>&1; then
    echo "❌ git is required."
    exit 1
fi

echo "📦 Syncing Syndra repository into $INSTALL_DIR"
if [ ! -d "$INSTALL_DIR/.git" ]; then
    git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"
else
    git -C "$INSTALL_DIR" pull --ff-only
fi

bash "$INSTALL_DIR/scripts/verify-artifacts.sh"

case "$PROFILE" in
    interactive)
        exec bash "$INSTALL_DIR/install.sh"
        ;;
    base)
        exec bash "$INSTALL_DIR/scripts/install-syndra-base.sh"
        ;;
    blue)
        bash "$INSTALL_DIR/scripts/install-syndra-base.sh"
        exec bash "$INSTALL_DIR/scripts/install-blue.sh"
        ;;
    red)
        bash "$INSTALL_DIR/scripts/install-syndra-base.sh"
        exec bash "$INSTALL_DIR/scripts/install-red.sh"
        ;;
    purple)
        bash "$INSTALL_DIR/scripts/install-syndra-base.sh"
        exec bash "$INSTALL_DIR/scripts/install-purple.sh"
        ;;
    root)
        bash "$INSTALL_DIR/scripts/install-syndra-base.sh"
        exec bash "$INSTALL_DIR/scripts/install-root.sh"
        ;;
esac
