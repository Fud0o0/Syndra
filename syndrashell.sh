#!/bin/bash
# SyndraShell — script de démarrage
# Lancé automatiquement par Hyprland via exec-once

INSTALL_DIR="$HOME/.config/SyndraShell"
LOG_FILE="/tmp/syndrashell.log"

# Journalisation
exec >> "$LOG_FILE" 2>&1
echo "[$(date '+%H:%M:%S')] Démarrage SyndraShell..."

# Vérifier l'installation
if [ ! -f "$INSTALL_DIR/main.py" ]; then
    echo "[ERREUR] SyndraShell non trouvé dans $INSTALL_DIR"
    exit 1
fi

export PROC_TITLE="syndrashell"

# Tuer toute instance existante
pkill -f "python.*main\.py" 2>/dev/null || true
sleep 0.3

# Attendre que Hyprland soit complètement prêt
sleep 1

# Installer la police tabler-icons si absente (silencieux)
FONT_SRC="$INSTALL_DIR/assets/fonts/tabler-icons/tabler-icons.ttf"
for FONT_DEST in "$HOME/.local/share/fonts/tabler-icons" "$HOME/.fonts/tabler-icons"; do
    if [ -f "$FONT_SRC" ] && [ ! -f "$FONT_DEST/tabler-icons.ttf" ]; then
        mkdir -p "$FONT_DEST"
        cp "$FONT_SRC" "$FONT_DEST/"
    fi
done
fc-cache -f 2>/dev/null || true

# Vérifier les dépendances Python critiques
for mod in gi fabric setproctitle watchdog; do
    python -c "import $mod" 2>/dev/null || {
        echo "[WARN] Module Python manquant: $mod"
        notify-send "SyndraShell" "Module manquant: $mod\nLancer: pip install --break-system-packages $mod" 2>/dev/null || true
    }
done

echo "[$(date '+%H:%M:%S')] Lancement de python main.py..."
cd "$INSTALL_DIR" && exec python main.py
