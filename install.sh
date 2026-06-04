#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║              SYNDRA SHELL — INSTALLATEUR                         ║
# ║   bash install.sh [blue-team|red-team|purple|green|mono]         ║
# ╚══════════════════════════════════════════════════════════════════╝
#
# Usage depuis le web :
#   bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) blue-team

set -euo pipefail

# ── Profil ──────────────────────────────────────────────────────────
PROFILE="${1:-default}"
REPO_URL="https://github.com/Fud0o0/Syndra.git"
INSTALL_DIR="$HOME/.config/SyndraShell"
CONFIG_JSON="$INSTALL_DIR/config/config.json"

VALID_PROFILES=("blue-team" "red-team" "purple" "green" "mono" "default")
VALID=false
for p in "${VALID_PROFILES[@]}"; do [[ "$p" == "$PROFILE" ]] && VALID=true && break; done
if ! $VALID; then
    echo "❌  Profil inconnu: '$PROFILE'"
    echo "    Valides: ${VALID_PROFILES[*]}"
    exit 1
fi

# ── Couleurs ────────────────────────────────────────────────────────
case "$PROFILE" in
    blue-team) PC="\033[0;34m" ;;
    red-team)  PC="\033[0;31m" ;;
    purple)    PC="\033[0;35m" ;;
    green)     PC="\033[0;32m" ;;
    mono)      PC="\033[0;37m" ;;
    *)         PC="\033[0;36m" ;;
esac
R="\033[0m"; B="\033[1m"; G="\033[0;32m"; Y="\033[0;33m"; E="\033[0;31m"

_ok()   { echo -e "  ${G}✓${R}  $1"; }
_warn() { echo -e "  ${Y}⚠${R}  $1"; }
_err()  { echo -e "  ${E}✗${R}  $1"; }
_info() { echo -e "  ${PC}→${R}  $1"; }
_step() { echo -e "\n${PC}${B}[$1]${R} $2"; }

ERRORS=0
WARNINGS=0

# ── Bannière ────────────────────────────────────────────────────────
clear
echo -e "${PC}${B}"
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║           SYNDRA SHELL  ·  INSTALLATEUR                  ║"
echo "  ║                                                           ║"
printf "  ║   Profil  :  %-44s║\n" "${PROFILE^^}"
printf "  ║   Cible   :  %-44s║\n" "$INSTALL_DIR"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${R}"

# ── Vérifications système ───────────────────────────────────────────
_step "1/7" "Vérifications système"

if [ ! -f /etc/arch-release ]; then
    _err "Arch Linux requis."
    exit 1
fi
_ok "Arch Linux détecté"

AVAIL=$(df -BG / | awk 'NR==2{gsub("G",""); print $4}')
if [ "$AVAIL" -lt 5 ]; then
    _warn "Espace disque faible: ${AVAIL}G (5G recommandé)"
    ((WARNINGS++))
else
    _ok "Espace disque: ${AVAIL}G disponible"
fi

if [ "$EUID" -eq 0 ]; then
    _err "Ne pas lancer en root."
    exit 1
fi
_ok "Utilisateur: $USER"

# ── AUR Helper ─────────────────────────────────────────────────────
_step "2/7" "AUR Helper"

if command -v yay &>/dev/null; then
    AUR="yay"; _ok "yay trouvé ($(yay --version 2>/dev/null | head -1))"
elif command -v paru &>/dev/null; then
    AUR="paru"; _ok "paru trouvé"
else
    _info "Installation de yay..."
    sudo pacman -S --needed --noconfirm git base-devel 2>/dev/null
    git clone https://aur.archlinux.org/yay.git /tmp/_yay_install
    (cd /tmp/_yay_install && makepkg -si --noconfirm 2>/dev/null)
    rm -rf /tmp/_yay_install
    AUR="yay"
    _ok "yay installé"
fi

# ── Paquets système ─────────────────────────────────────────────────
_step "3/7" "Paquets système"

declare -A PKG_DESC=(
    [hyprland]="Compositeur Wayland"
    [swww]="Fond d'écran Wayland"
    [dunst]="Notifications"
    [kitty]="Terminal"
    [wofi]="Lanceur d'applications"
    [wl-clipboard]="Presse-papier Wayland"
    [xdg-desktop-portal-hyprland]="Portail XDG"
    [qt6-wayland]="Qt6 Wayland"
    [docker]="Conteneurs Docker"
    [docker-compose]="Docker Compose"
    [playerctl]="Contrôle médias"
    [brightnessctl]="Contrôle luminosité"
    [imagemagick]="Traitement images"
    [ffmpeg]="Encodage vidéo"
    [python]="Python 3"
    [python-gobject]="Bindings GTK Python"
    [python-pywayland]="Bindings Wayland Python"
    [python-pip]="Gestionnaire paquets Python"
    [git]="Contrôle de version"
    [curl]="Transferts HTTP"
)

MISSING_PKGS=()
for pkg in "${!PKG_DESC[@]}"; do
    if pacman -Q "$pkg" &>/dev/null; then
        _ok "${PKG_DESC[$pkg]} ($pkg)"
    else
        _warn "${PKG_DESC[$pkg]} ($pkg) — à installer"
        MISSING_PKGS+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    _info "Installation de ${#MISSING_PKGS[@]} paquet(s)..."
    $AUR -S --needed --noconfirm "${MISSING_PKGS[@]}" 2>&1 | \
        grep -E "^(erreur|error|warning)" | while read -r l; do _warn "$l"; done || true
    _ok "Paquets système installés"
fi

# AUR spécifiques
AUR_PKGS=(python-fabric-git)
for pkg in "${AUR_PKGS[@]}"; do
    if ! pacman -Q "$pkg" &>/dev/null; then
        _info "Installation AUR: $pkg..."
        $AUR -S --needed --noconfirm "$pkg" 2>/dev/null && _ok "$pkg installé" || { _warn "$pkg échoué (non critique)"; ((WARNINGS++)); }
    else
        _ok "$pkg (AUR)"
    fi
done

# ── Dépendances Python ──────────────────────────────────────────────
_step "4/7" "Dépendances Python"

declare -A PY_DESC=(
    [setproctitle]="Titre de processus"
    [watchdog]="Surveillance fichiers"
    [Pillow]="Traitement images (PIL)"
    [requests]="Requêtes HTTP"
    [ijson]="Parsing JSON streamé"
)

PY_FLAGS="--break-system-packages --quiet"
MISSING_PY=()

for pkg in "${!PY_DESC[@]}"; do
    import_name="${pkg,,}"
    [[ "$pkg" == "Pillow" ]] && import_name="PIL"
    if python -c "import $import_name" 2>/dev/null; then
        _ok "${PY_DESC[$pkg]} ($pkg)"
    else
        _warn "${PY_DESC[$pkg]} ($pkg) — à installer"
        MISSING_PY+=("$pkg")
    fi
done

if [ ${#MISSING_PY[@]} -gt 0 ]; then
    _info "pip install ${MISSING_PY[*]}..."
    pip install $PY_FLAGS "${MISSING_PY[@]}" 2>&1 | grep -v "^$" | tail -3 || \
    pip install --user "${MISSING_PY[@]}" 2>/dev/null || { _warn "Certains paquets Python échoués"; ((WARNINGS++)); }
    _ok "Dépendances Python installées"
fi

# ── Syndra Shell ────────────────────────────────────────────────────
_step "5/7" "Syndra Shell"

if [ ! -d "$INSTALL_DIR/.git" ]; then
    _info "Clonage du dépôt..."
    git clone "$REPO_URL" "$INSTALL_DIR" --quiet
    _ok "Dépôt cloné"
else
    _info "Mise à jour du dépôt..."
    cd "$INSTALL_DIR" && git pull --ff-only --quiet 2>/dev/null || git fetch --quiet
    _ok "Dépôt à jour ($(git -C "$INSTALL_DIR" log -1 --format='%h %s' 2>/dev/null))"
fi

# Écrire le profil dans config.json
mkdir -p "$(dirname "$CONFIG_JSON")"
if [ -f "$CONFIG_JSON" ]; then
    python - <<PYEOF
import json
with open("$CONFIG_JSON") as f:
    d = json.load(f)
d["syndra_profile"] = "$PROFILE"
with open("$CONFIG_JSON", "w") as f:
    json.dump(d, f, indent=2)
PYEOF
else
    echo "{\"syndra_profile\": \"$PROFILE\"}" > "$CONFIG_JSON"
fi
_ok "Profil '$PROFILE' enregistré dans config.json"

# ── Configuration ───────────────────────────────────────────────────
_step "6/7" "Configuration"

HYPR_DIR="$HOME/.config/hypr"
mkdir -p "$HYPR_DIR" ~/Pictures/Wallpapers ~/Pictures/Screenshots
_ok "Répertoires créés"

# Rendre les scripts exécutables
chmod +x "$INSTALL_DIR/syndrashell.sh" 2>/dev/null || true
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null || true
_ok "Scripts rendus exécutables"

# Lier hyprland.conf — TOUJOURS forcer (écrase le config auto-généré de Hyprland)
rm -f "$HYPR_DIR/hyprland.conf"
ln -sf "$INSTALL_DIR/config/hypr/hyprland.conf" "$HYPR_DIR/hyprland.conf"
_ok "hyprland.conf → lien symbolique forcé vers Syndra"

# Vérifier que exec-once syndrashell est bien dans la config
if ! grep -q "syndrashell" "$INSTALL_DIR/config/hypr/hyprland.conf" 2>/dev/null; then
    _warn "exec-once syndrashell absent du hyprland.conf !"
    ((WARNINGS++))
else
    _ok "exec-once syndrashell.sh présent dans hyprland.conf"
fi

# Police tabler-icons
FONT_SRC="$INSTALL_DIR/assets/fonts/tabler-icons/tabler-icons.ttf"
if [ -f "$FONT_SRC" ]; then
    mkdir -p "$HOME/.local/share/fonts/tabler-icons" "$HOME/.fonts/tabler-icons"
    cp "$FONT_SRC" "$HOME/.local/share/fonts/tabler-icons/"
    cp "$FONT_SRC" "$HOME/.fonts/tabler-icons/"
    fc-cache -f 2>/dev/null
    _ok "Police tabler-icons installée"
fi

# Docker
if command -v docker &>/dev/null; then
    sudo systemctl enable --now docker 2>/dev/null || true
    sudo usermod -aG docker "$USER" 2>/dev/null || true
    _ok "Docker configuré"
fi

# ── Conteneurs du profil ────────────────────────────────────────────
_step "7/7" "Conteneurs ($PROFILE)"

COMPOSE="$INSTALL_DIR/containers/${PROFILE}/docker-compose.yml"
if [ -f "$COMPOSE" ] && command -v docker &>/dev/null; then
    _info "Téléchargement des images Docker (peut prendre du temps)..."
    docker compose -f "$COMPOSE" pull --quiet 2>/dev/null || \
    docker-compose -f "$COMPOSE" pull 2>/dev/null || \
    { _warn "Pull Docker reporté au premier lancement"; ((WARNINGS++)); }
    _ok "Images Docker prêtes"
else
    _warn "Conteneurs non disponibles pour le profil '$PROFILE'"
    ((WARNINGS++))
fi

# ── Résumé ───────────────────────────────────────────────────────────
echo ""
echo -e "${PC}${B}"
echo "  ╔══════════════════════════════════════════════════════════╗"
if [ "$ERRORS" -eq 0 ]; then
echo "  ║      ✅  INSTALLATION RÉUSSIE                            ║"
else
echo "  ║      ⚠   INSTALLATION AVEC ERREURS                       ║"
fi
echo "  ╠══════════════════════════════════════════════════════════╣"
printf "  ║   Profil     : %-43s║\n" "$PROFILE"
printf "  ║   Erreurs    : %-43s║\n" "$ERRORS"
printf "  ║   Avertiss.  : %-43s║\n" "$WARNINGS"
echo "  ╠══════════════════════════════════════════════════════════╣"
echo "  ║   Pour démarrer Syndra :                                 ║"
echo "  ║     • Déconnectez-vous et sélectionnez Hyprland          ║"
echo "  ║     • OU tapez : Hyprland  (depuis un TTY)               ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${R}"
