#!/bin/bash
# SyndraShell startup script

INSTALL_DIR="$HOME/.config/SyndraShell"

if [ ! -d "$INSTALL_DIR" ]; then
    echo "Erreur: SyndraShell non trouvé dans $INSTALL_DIR"
    exit 1
fi

echo "Démarrage de SyndraShell..."

export PROC_TITLE="syndrashell"

# Installer la police tabler-icons si absente
FONT_DEST="$HOME/.local/share/fonts/tabler-icons"
FONT_SRC="$INSTALL_DIR/assets/fonts/tabler-icons/tabler-icons.ttf"
if [ -f "$FONT_SRC" ] && [ ! -f "$FONT_DEST/tabler-icons.ttf" ]; then
    mkdir -p "$FONT_DEST"
    cp "$FONT_SRC" "$FONT_DEST/"
    fc-cache -f "$FONT_DEST" 2>/dev/null || true
    echo "Police tabler-icons installée."
fi

# Attendre que Hyprland soit prêt
sleep 1

# Lancer depuis le dossier d'installation pour que les imports Python fonctionnent
cd "$INSTALL_DIR" && python main.py
