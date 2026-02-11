#!/bin/bash
# Script utilitaire pour gérer le lancement automatique de l'interface provisoire

AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/syndra-provisional.desktop"
DESKTOP_FILE="$HOME/.local/share/applications/syndra-provisional.desktop"

show_status() {
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║   Gestion du Lancement Automatique - Interface Provisoire ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    if [ -f "$AUTOSTART_FILE" ]; then
        echo "✅ Lancement automatique : ACTIVÉ"
        echo "   L'interface se lance au démarrage de la session"
    else
        echo "❌ Lancement automatique : DÉSACTIVÉ"
        echo "   L'interface ne se lance pas automatiquement"
    fi
    echo ""
}

enable_autostart() {
    if [ ! -f "$DESKTOP_FILE" ]; then
        echo "❌ Erreur: Le fichier desktop n'existe pas"
        echo "   Veuillez réinstaller Syndra"
        exit 1
    fi
    
    mkdir -p "$AUTOSTART_DIR"
    cp "$DESKTOP_FILE" "$AUTOSTART_FILE"
    echo "✅ Lancement automatique activé!"
    echo "   L'interface se lancera au prochain démarrage"
}

disable_autostart() {
    if [ -f "$AUTOSTART_FILE" ]; then
        rm "$AUTOSTART_FILE"
        echo "✅ Lancement automatique désactivé!"
        echo "   L'interface ne se lancera plus automatiquement"
    else
        echo "ℹ️  Le lancement automatique n'était pas activé"
    fi
}

show_help() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  enable    Activer le lancement automatique"
    echo "  disable   Désactiver le lancement automatique"
    echo "  status    Afficher l'état actuel"
    echo "  toggle    Inverser l'état actuel"
    echo "  help      Afficher cette aide"
    echo ""
}

case "${1:-status}" in
    enable)
        enable_autostart
        ;;
    disable)
        disable_autostart
        ;;
    status)
        show_status
        ;;
    toggle)
        if [ -f "$AUTOSTART_FILE" ]; then
            disable_autostart
        else
            enable_autostart
        fi
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ Option invalide: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
