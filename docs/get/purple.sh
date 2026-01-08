#!/bin/bash
# Syndra Quick Install - Purple Team Edition
# Auto-installs base + Purple Team tools (Red + Blue)

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║        SYNDRA SHELL - INSTALLATION RAPIDE PURPLE TEAM         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Cette installation va automatiquement:"
echo "  1. Installer Syndra base (Hyprland + Interface)"
echo "  2. Installer les outils Purple Team (Red + Blue complet)"
echo ""
echo "Espace disque requis: ~25 GB"
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

cd "$INSTALL_DIR"

# Step 1: Install base
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "ÉTAPE 1/2: Installation de la base Syndra"
echo "═══════════════════════════════════════════════════════════════"
bash "$INSTALL_DIR/scripts/install-syndra-base.sh"

# Step 2: Install Purple Team
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "ÉTAPE 2/2: Installation Purple Team"
echo "═══════════════════════════════════════════════════════════════"
bash "$INSTALL_DIR/scripts/install-purple.sh"

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║    ✅ INSTALLATION PURPLE TEAM COMPLÈTE!                      ║"
echo "║                                                               ║"
echo "║  Déconnectez-vous et sélectionnez Hyprland pour démarrer     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
