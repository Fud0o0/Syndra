#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║              SYNDRA SHELL — INSTALLER                        ║
# ║   bash install.sh [blue-team|red-team|purple|green|mono]     ║
# ║   curl -sL https://raw.githubusercontent.com/               ║
# ║        Fud0o0/Syndra/main/install.sh | bash -s -- blue-team  ║
# ╚══════════════════════════════════════════════════════════════╝

PROFILE="${1:-default}"
REPO_URL="https://github.com/Fud0o0/Syndra.git"
INSTALL_DIR="$HOME/.config/SyndraShell"
CONFIG_JSON="$INSTALL_DIR/config/config.json"

# ── Validation du profil ──────────────────────────────────────────
VALID_PROFILES=("blue-team" "red-team" "purple" "green" "mono" "default")
VALID=false
for p in "${VALID_PROFILES[@]}"; do [[ "$p" == "$PROFILE" ]] && VALID=true; done
if ! $VALID; then
    echo "❌  Profil inconnu: $PROFILE"
    echo "    Profils valides: ${VALID_PROFILES[*]}"
    exit 1
fi

# ── Couleurs terminal ──────────────────────────────────────────────
case "$PROFILE" in
    blue-team) C="\033[0;34m" ;;   # bleu
    red-team)  C="\033[0;31m" ;;   # rouge
    purple)    C="\033[0;35m" ;;   # violet
    green)     C="\033[0;32m" ;;   # vert
    mono)      C="\033[0;37m" ;;   # gris
    *)         C="\033[0;36m" ;;   # cyan (default)
esac
NC="\033[0m"
BOLD="\033[1m"

echo -e "${C}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              SYNDRA SHELL — $(printf '%-34s' "${PROFILE^^}")║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ── Pré-requis ─────────────────────────────────────────────────────
if [ ! -f /etc/arch-release ]; then
    echo "❌  Ce script nécessite Arch Linux."
    exit 1
fi

echo -e "${C}[1/6] Vérification de l'espace disque...${NC}"
AVAIL=$(df -BG / | awk 'NR==2{print $4}' | tr -d G)
if [ "$AVAIL" -lt 5 ]; then
    echo "⚠️   Espace insuffisant (${AVAIL}G disponible, 5G requis)"
    read -rp "Continuer quand même? [y/N] " yn
    [[ "$yn" =~ ^[Yy]$ ]] || exit 1
fi

# ── AUR helper ─────────────────────────────────────────────────────
echo -e "${C}[2/6] Vérification de l'AUR helper...${NC}"
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
    echo "  → Installation de yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay-install
    (cd /tmp/yay-install && makepkg -si --noconfirm)
    rm -rf /tmp/yay-install
fi
AUR=$(command -v yay 2>/dev/null || command -v paru 2>/dev/null)

# ── Dépendances base ───────────────────────────────────────────────
echo -e "${C}[3/6] Installation des dépendances Syndra...${NC}"
$AUR -S --needed --noconfirm \
    python python-gobject python-pywayland python-fabric-git \
    hyprland swww dunst kitty wofi wl-clipboard \
    xdg-desktop-portal-hyprland qt6-wayland \
    docker docker-compose \
    playerctl brightnessctl \
    imagemagick ffmpeg \
    2>&1 | grep -E "error:|warning:|installed|skipping" || true

# Activer Docker
sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# Python deps
if [ -f "$INSTALL_DIR/requirements.txt" ] || [ -f /tmp/syndra-req.txt ]; then
    pip install --user --break-system-packages \
        requests pillow setproctitle 2>/dev/null || true
fi

# ── Cloner / mettre à jour Syndra ─────────────────────────────────
echo -e "${C}[4/6] Installation de Syndra Shell...${NC}"
if [ ! -d "$INSTALL_DIR/.git" ]; then
    git clone "$REPO_URL" "$INSTALL_DIR"
else
    cd "$INSTALL_DIR" && git pull --ff-only 2>/dev/null || true
fi
cd "$INSTALL_DIR"

# Écrire le profil dans config.json (crée le fichier si absent)
mkdir -p "$(dirname "$CONFIG_JSON")"
if [ -f "$CONFIG_JSON" ]; then
    python3 -c "
import json
with open('$CONFIG_JSON') as f:
    d = json.load(f)
d['syndra_profile'] = '$PROFILE'
with open('$CONFIG_JSON', 'w') as f:
    json.dump(d, f, indent=2)
print('  → Profil $PROFILE enregistré dans config.json')
"
else
    echo "{\"syndra_profile\": \"$PROFILE\"}" > "$CONFIG_JSON"
    echo "  → config.json créé avec profil $PROFILE"
fi

# ── Conteneurs Docker par profil ──────────────────────────────────
echo -e "${C}[5/6] Préparation des conteneurs $PROFILE...${NC}"
COMPOSE_FILE="$INSTALL_DIR/containers/${PROFILE}/docker-compose.yml"
if [ -f "$COMPOSE_FILE" ]; then
    echo "  → Téléchargement des images Docker..."
    docker compose -f "$COMPOSE_FILE" pull 2>/dev/null || \
    docker-compose -f "$COMPOSE_FILE" pull 2>/dev/null || \
    echo "  ⚠️  Pull des images échoué (continuons, elles seront téléchargées au 1er lancement)"
else
    echo "  ⚠️  Pas de docker-compose.yml pour le profil $PROFILE (normal pour 'default')"
fi

# ── Configuration Hyprland ────────────────────────────────────────
echo -e "${C}[6/6] Configuration de l'environnement...${NC}"
HYPR_DIR="$HOME/.config/hypr"
mkdir -p "$HYPR_DIR" ~/Pictures/Wallpapers ~/Pictures/Screenshots

# Lier la config Hyprland si pas déjà fait
if [ ! -f "$HYPR_DIR/hyprland.conf" ]; then
    ln -sf "$INSTALL_DIR/config/hypr/hyprland.conf" "$HYPR_DIR/hyprland.conf"
    echo "  → hyprland.conf lié"
fi

# Police tabler-icons
FONT_SRC="$INSTALL_DIR/assets/fonts/tabler-icons/tabler-icons.ttf"
if [ -f "$FONT_SRC" ]; then
    mkdir -p "$HOME/.local/share/fonts/tabler-icons"
    cp "$FONT_SRC" "$HOME/.local/share/fonts/tabler-icons/"
    fc-cache -f 2>/dev/null || true
    echo "  → Police tabler-icons installée"
fi

# ── Résumé ────────────────────────────────────────────────────────
echo ""
echo -e "${C}${BOLD}╔══════════════════════════════════════════════════════════════╗"
echo "║           ✅  SYNDRA SHELL INSTALLÉ — ${PROFILE^^}$(printf '%*s' $((27-${#PROFILE})) '')║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  Profil        : $PROFILE$(printf '%*s' $((44-${#PROFILE})) '')║"
echo "║  Répertoire    : $INSTALL_DIR$(printf '%*s' $((62-${#INSTALL_DIR}-18)) '')║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  Pour lancer maintenant :                                    ║"
echo "║    cd $INSTALL_DIR                                            ║"
echo "║    python main.py                                             ║"
echo "║                                                               ║"
echo "║  Hyprland démarre Syndra automatiquement via exec-once.       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
