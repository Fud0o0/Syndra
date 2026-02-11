#!/bin/bash
# Syndra Uninstallation Script
# This script completely removes Syndra Shell from your system

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              SYNDRA SHELL - DÉSINSTALLATION                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "⚠️  ATTENTION: Cette action va supprimer:"
echo ""
echo "  • Syndra Shell (~/.config/SyndraShell)"
echo "  • Configuration Hyprland (~/.config/hypr)"
echo "  • Configuration Waybar (~/.config/waybar)"
echo "  • Configuration Kitty (~/.config/kitty)"
echo "  • Configuration Wofi (~/.config/wofi)"
echo "  • Configuration Dunst (~/.config/dunst)"
echo "  • Cache Syndra (~/.cache/syndrashell)"
echo "  • Fichier wallpaper actuel (~/.current.wall)"
echo "  • Scripts systemd/autostart liés à Syndra"
echo ""
echo "📁 Les wallpapers dans ~/Pictures/Wallpapers seront CONSERVÉS"
echo ""
read -p "❓ Voulez-vous vraiment désinstaller Syndra Shell? [y/N]: " -n 1 -r
echo
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "✅ Désinstallation annulée."
    exit 0
fi

echo "🗑️  Désinstallation en cours..."
echo ""

# Function to safely remove directories/files
safe_remove() {
    if [ -e "$1" ]; then
        echo "  ✓ Suppression: $1"
        rm -rf "$1"
    else
        echo "  ⊘ Déjà absent: $1"
    fi
}

# Stop running processes
echo "1/5 - Arrêt des processus Syndra..."
killall -9 syndrashell 2>/dev/null || true
killall -9 python 2>/dev/null || true  # Be careful with this
pkill -f "main.py" 2>/dev/null || true
pkill -f "SyndraShell" 2>/dev/null || true
sleep 1

# Remove Syndra Shell main directory
echo ""
echo "2/5 - Suppression de Syndra Shell..."
safe_remove "$HOME/.config/SyndraShell"

# Remove configuration directories
echo ""
echo "3/5 - Suppression des configurations..."
safe_remove "$HOME/.config/hypr"
safe_remove "$HOME/.config/waybar"
safe_remove "$HOME/.config/kitty"
safe_remove "$HOME/.config/wofi"
safe_remove "$HOME/.config/dunst"

# Remove cache and temporary files
echo ""
echo "4/5 - Suppression du cache..."
safe_remove "$HOME/.cache/syndrashell"
safe_remove "$HOME/.current.wall"
safe_remove "$HOME/.fonts/zed-sans"  # Remove downloaded fonts

# Remove autostart/systemd entries
echo ""
echo "5/5 - Nettoyage des services..."
safe_remove "$HOME/.config/autostart/syndrashell.desktop"
safe_remove "$HOME/.config/systemd/user/syndrashell.service"

# Reload systemd if needed
if command -v systemctl &> /dev/null; then
    systemctl --user daemon-reload 2>/dev/null || true
fi

# Optional: Remove Hyprland session from display manager
echo ""
read -p "❓ Voulez-vous également supprimer Hyprland du système? [y/N]: " -n 1 -r
echo
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🗑️  Suppression de Hyprland..."
    
    # Detect package manager
    if command -v pacman &> /dev/null; then
        echo "  Arch Linux détecté..."
        sudo pacman -Rns hyprland --noconfirm 2>/dev/null || true
    elif command -v apt &> /dev/null; then
        echo "  Debian/Ubuntu détecté..."
        sudo apt remove hyprland -y 2>/dev/null || true
    elif command -v dnf &> /dev/null; then
        echo "  Fedora détecté..."
        sudo dnf remove hyprland -y 2>/dev/null || true
    else
        echo "  ⚠️  Gestionnaire de paquets non reconnu. Supprimez Hyprland manuellement."
    fi
    
    # Remove Hyprland desktop entry
    safe_remove "/usr/share/wayland-sessions/hyprland.desktop"
    safe_remove "/usr/share/xsessions/hyprland.desktop"
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║          ✅ DÉSINSTALLATION TERMINÉE AVEC SUCCÈS! ✅          ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Syndra Shell a été complètement supprimé de votre système.   ║"
echo "║                                                               ║"
echo "║  Si vous souhaitez réinstaller Syndra:                        ║"
echo "║  → ./install.sh                                               ║"
echo "║                                                               ║"
echo "║  Merci d'avoir utilisé Syndra Shell! 👋                       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
