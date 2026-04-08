#!/bin/bash
# Syndra Quick Install - Blue Team Edition
# Secure flow: sync repo, verify checksum/signature, install profile

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║         SYNDRA SHELL - INSTALLATION RAPIDE BLUE TEAM          ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Cette installation va automatiquement:"
echo "  1. Synchroniser le depot Syndra"
echo "  2. Verifier SHA256 (+ signature si disponible)"
echo "  3. Installer Syndra base + outils Blue Team"
echo ""
echo "Espace disque requis: ~13 GB"
echo ""

INSTALL_DIR="$HOME/.config/SyndraShell"
REPO_URL="https://github.com/Fud0o0/Syndra.git"

# Clone or update repository
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📦 Clonage du dépôt Syndra..."
    git clone "$REPO_URL" "$INSTALL_DIR"
else
    echo "🔄 Mise à jour du dépôt Syndra..."
    cd "$INSTALL_DIR" && git pull
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "ÉTAPE UNIQUE: Installation sécurisée Blue Team"
echo "═══════════════════════════════════════════════════════════════"
bash "$INSTALL_DIR/scripts/secure-install.sh" blue

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     ✅ INSTALLATION BLUE TEAM COMPLÈTE!                       ║"
echo "║                                                               ║"
echo "║  Déconnectez-vous et sélectionnez Hyprland pour démarrer     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
