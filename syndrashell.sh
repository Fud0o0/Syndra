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

# Vérifier les modules pip uniquement (gi et fabric sont des paquets système)
for mod in setproctitle watchdog; do
    python -c "import $mod" 2>/dev/null || {
        echo "[WARN] $mod manquant — installation automatique..."
        pip install --break-system-packages "$mod" 2>/dev/null || pip install --user "$mod" 2>/dev/null || true
    }
done

# Afficher le profil actif
PROFILE=$(python3 -c "import json,os; d=json.load(open(os.path.expanduser('~/.config/SyndraShell/config/config.json'))); print(d.get('syndra_profile','default'))" 2>/dev/null || echo "default")
echo "[$(date '+%H:%M:%S')] Profil: $PROFILE"

# ── Fond d'écran par profil via awww ──────────────────────────────
# Le fond d'écran du profil prime ; sinon on garde ~/.current.wall existant.
PROFILE_WALL="$INSTALL_DIR/assets/wallpapers/${PROFILE}.png"
WALL="$HOME/.current.wall"

if [ -f "$PROFILE_WALL" ]; then
    ln -sf "$PROFILE_WALL" "$WALL"
    echo "[wallpaper] profil '$PROFILE' → $PROFILE_WALL"
elif [ ! -e "$WALL" ] && [ -f "$INSTALL_DIR/assets/wallpapers/default.png" ]; then
    ln -sf "$INSTALL_DIR/assets/wallpapers/default.png" "$WALL"
    echo "[wallpaper] défaut → default.png"
fi

if command -v awww &>/dev/null; then
    awww query &>/dev/null 2>&1 || awww-daemon &
    for i in $(seq 1 20); do
        awww query &>/dev/null 2>&1 && break
        sleep 0.5
    done

    if [ -e "$WALL" ]; then
        REAL_WALL=$(realpath "$WALL" 2>/dev/null || readlink -f "$WALL")
        echo "[wallpaper] application de: $REAL_WALL"
        awww img "$REAL_WALL" --transition-type fade --transition-duration 2 && \
            echo "[wallpaper] OK" || echo "[wallpaper] ERREUR awww img"
    else
        echo "[wallpaper] ERREUR: aucun fond d'écran trouvé"
    fi
else
    echo "[wallpaper] awww non installé — sudo pacman -S awww"
fi

echo "[$(date '+%H:%M:%S')] Lancement de python main.py..."
cd "$INSTALL_DIR" && exec python main.py
