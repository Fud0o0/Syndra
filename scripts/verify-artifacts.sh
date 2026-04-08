#!/bin/bash
# Verify integrity (SHA256) and optional GPG signature for install artifacts.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CHECKSUM_FILE="$REPO_DIR/checksums/sha256sums.txt"
SIGNATURE_FILE="$REPO_DIR/checksums/sha256sums.txt.asc"

if ! command -v sha256sum >/dev/null 2>&1; then
    echo "❌ sha256sum is required."
    exit 1
fi

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "❌ Missing checksum manifest: $CHECKSUM_FILE"
    exit 1
fi

echo "🔍 Verifying SHA256 checksums..."
(
    cd "$REPO_DIR"
    sha256sum -c "$CHECKSUM_FILE"
)

echo "✅ SHA256 checks passed."

if [ "${SYNDRA_REQUIRE_SIGNATURE:-0}" = "1" ]; then
    if ! command -v gpg >/dev/null 2>&1; then
        echo "❌ GPG is required when SYNDRA_REQUIRE_SIGNATURE=1"
        exit 1
    fi
    if [ ! -f "$SIGNATURE_FILE" ]; then
        echo "❌ Missing signature file: $SIGNATURE_FILE"
        exit 1
    fi

    echo "🔐 Verifying signed checksum manifest..."
    gpg --verify "$SIGNATURE_FILE" "$CHECKSUM_FILE"
    echo "✅ Signature is valid."
else
    if command -v gpg >/dev/null 2>&1 && [ -f "$SIGNATURE_FILE" ]; then
        echo "🔐 Verifying signed checksum manifest..."
        gpg --verify "$SIGNATURE_FILE" "$CHECKSUM_FILE"
        echo "✅ Signature is valid."
    else
        echo "ℹ️ Signature verification skipped (set SYNDRA_REQUIRE_SIGNATURE=1 to enforce)."
    fi
fi
