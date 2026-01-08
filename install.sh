#!/bin/bash
# Syndra Installation Script - Main Installer
# This script guides you through the Syndra Shell installation process

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                  SYNDRA SHELL - INSTALLATEUR                  ║"
echo "║              Installation modulaire en 2 étapes               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Bienvenue dans l'installateur Syndra Shell!"
echo ""
echo "L'installation se fait maintenant en 2 étapes:"
echo ""
echo "  1️⃣  Installation de BASE (Syndra Shell + Hyprland)"
echo "      → Interface, fonctionnalités core, environnement Wayland"
echo ""
echo "  2️⃣  Installation TEAM (Outils spécifiques)"
echo "      → Blue Team  : Outils défensifs (IDS, firewall, SIEM...)"
echo "      → Red Team   : Outils offensifs (pentest, exploitation...)"
echo "      → Purple Team: Couverture complète (Red + Blue)"
echo "      → Root Me    : Outils CTF et challenges"
echo "      → Custom     : Configuration personnalisée"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if base installation exists
INSTALL_DIR="$HOME/.config/SyndraShell"

if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/main.py" ]; then
    echo "✅ Syndra base est déjà installé!"
    echo ""
    echo "Voulez-vous:"
    echo "  1) Réinstaller la base (update)"
    echo "  2) Installer/changer les outils team"
    echo "  3) Quitter"
    echo ""
    read -p "Votre choix [1-3]: " choice
    
    case $choice in
        1)
            echo ""
            echo "🔄 Réinstallation de la base Syndra..."
            bash "$SCRIPT_DIR/scripts/install-syndra-base.sh"
            ;;
        2)
            # Continue to team selection below
            ;;
        3)
            echo "Installation annulée."
            exit 0
            ;;
        *)
            echo "❌ Choix invalide."
            exit 1
            ;;
    esac
else
    echo "📦 Étape 1/2: Installation de la base Syndra"
    echo ""
    echo "Cette étape installe:"
    echo "  • Hyprland (compositeur Wayland)"
    echo "  • Syndra Shell (interface)"
    echo "  • Waybar, Kitty, Wofi, Dunst"
    echo "  • Dépendances Python"
    echo "  • Configuration de base"
    echo ""
    read -p "Continuer avec l'installation de base? [Y/n]: " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation annulée."
        exit 0
    fi
    
    echo ""
    bash "$SCRIPT_DIR/scripts/install-syndra-base.sh"
    
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo ""
fi

# Team selection
echo "📦 Étape 2/2: Choix des outils team"
echo ""
echo "Choisissez votre profil d'outils:"
echo ""
echo "  1) 🔵 Blue Team   - Défensif (~8 GB)"
echo "     IDS/IPS, Firewall, Antivirus, Monitoring, SIEM"
echo ""
echo "  2) 🔴 Red Team    - Offensif (~10 GB)"
echo "     Pentest, Exploitation, Password cracking, Reverse"
echo ""
echo "  3) 🟣 Purple Team - Complet (~20 GB)"
echo "     Tous les outils Red + Blue"
echo ""
echo "  4) ⚫ Root Me     - CTF (~13 GB)"
echo "     Reverse, Pwn, Crypto, Forensics, Web exploitation"
echo ""
echo "  5) 🎨 Custom      - Personnalisé"
echo "     Configuration à la carte"
echo ""
echo "  6) ⏭️  Passer      - Installer plus tard"
echo ""
read -p "Votre choix [1-6]: " team_choice

case $team_choice in
    1)
        echo ""
        echo "🔵 Installation Blue Team..."
        bash "$SCRIPT_DIR/scripts/install-blue.sh"
        ;;
    2)
        echo ""
        echo "🔴 Installation Red Team..."
        bash "$SCRIPT_DIR/scripts/install-red.sh"
        ;;
    3)
        echo ""
        echo "🟣 Installation Purple Team..."
        bash "$SCRIPT_DIR/scripts/install-purple.sh"
        ;;
    4)
        echo ""
        echo "⚫ Installation Root Me/CTF..."
        bash "$SCRIPT_DIR/scripts/install-root.sh"
        ;;
    5)
        echo ""
        echo "🎨 Installation Custom..."
        if [ -f "$SCRIPT_DIR/scripts/install-custom.sh" ]; then
            bash "$SCRIPT_DIR/scripts/install-custom.sh"
        else
            echo "⚠️  Le script install-custom.sh n'existe pas encore."
            echo "   Vous pouvez le créer dans scripts/ en vous basant sur les autres."
        fi
        ;;
    6)
        echo ""
        echo "Installation des outils passée."
        echo "Vous pouvez lancer un script team plus tard depuis scripts/"
        ;;
    *)
        echo "❌ Choix invalide."
        exit 1
        ;;
esac

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              🎉 INSTALLATION SYNDRA TERMINÉE! 🎉              ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Pour démarrer Syndra Shell:                                  ║"
echo "║                                                               ║"
echo "║  1. Déconnectez-vous de votre session                        ║"
echo "║  2. Sélectionnez 'Hyprland' comme environnement              ║"
echo "║  3. Connectez-vous                                            ║"
echo "║                                                               ║"
echo "║  Raccourcis clavier principaux:                               ║"
echo "║  • SUPER + D      → Dashboard Syndra                          ║"
echo "║  • SUPER + R      → Lanceur d'applications                    ║"
echo "║  • SUPER + Enter  → Terminal (Kitty)                          ║"
echo "║  • SUPER + Q      → Fermer fenêtre                            ║"
echo "║                                                               ║"
echo "║  Documentation: https://github.com/Fud0o0/Syndra              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
