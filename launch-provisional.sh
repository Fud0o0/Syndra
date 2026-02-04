#!/bin/bash
# Script de lancement de l'interface provisoire Syndra

INSTALL_DIR="$HOME/.config/SyndraShell"
INTERFACE_SCRIPT="$INSTALL_DIR/provisional_interface.py"

# Vérifier si l'interface existe
if [ ! -f "$INTERFACE_SCRIPT" ]; then
    echo "❌ Erreur: Interface provisoire introuvable"
    echo "   Chemin attendu: $INTERFACE_SCRIPT"
    echo ""
    echo "Assurez-vous que Syndra est installé correctement."
    exit 1
fi

# Lancer l'interface
echo "🎨 Lancement de l'interface provisoire Syndra..."
python "$INTERFACE_SCRIPT"
