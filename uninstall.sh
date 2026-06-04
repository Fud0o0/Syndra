#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║           SYNDRA SHELL — DÉSINSTALLATEUR                         ║
# ║   bash uninstall.sh [--full]                                     ║
# ║   --full  : supprime aussi Hyprland + conteneurs Docker          ║
# ╚══════════════════════════════════════════════════════════════════╝

FULL_REMOVE=false
[[ "${1:-}" == "--full" ]] && FULL_REMOVE=true

INSTALL_DIR="$HOME/.config/SyndraShell"

# ── Couleurs ─────────────────────────────────────────────────────────
R="\033[0m"; B="\033[1m"
G="\033[0;32m"; Y="\033[0;33m"; E="\033[0;31m"; C="\033[0;36m"

_ok()   { echo -e "  ${G}✓${R}  $1"; }
_skip() { echo -e "  ${C}–${R}  $1 (déjà absent)"; }
_warn() { echo -e "  ${Y}⚠${R}  $1"; }
_step() { echo -e "\n${C}${B}[$1]${R} $2"; }

rm_safe() {
    local target="$1"
    local label="${2:-$1}"
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
        _ok "Supprimé : $label"
    else
        _skip "$label"
    fi
}

# ── Bannière ─────────────────────────────────────────────────────────
clear
echo -e "${E}${B}"
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║         SYNDRA SHELL  ·  DÉSINSTALLATEUR                 ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${R}"
echo "  Ce script va supprimer :"
echo ""
echo "    • Syndra Shell          ($INSTALL_DIR)"
echo "    • Config Hyprland       (~/.config/hypr)"
echo "    • Config Kitty/Wofi/Dunst"
echo "    • Cache Syndra          (~/.cache/syndrashell)"
echo "    • Police tabler-icons   (~/.local/share/fonts/tabler-icons)"
echo "    • Fichier wallpaper     (~/.current.wall)"
if $FULL_REMOVE; then
echo ""
echo "    • [--full] Hyprland     (paquet système)"
echo "    • [--full] Conteneurs Docker Syndra"
fi
echo ""
echo -e "  ${Y}Les wallpapers dans ~/Pictures/Wallpapers sont CONSERVÉS.${R}"
echo ""
read -rp "  Confirmer la désinstallation ? [y/N] : " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || { echo -e "\n  ${G}Annulé.${R}\n"; exit 0; }

# ── 1. Arrêt des processus ──────────────────────────────────────────
_step "1/5" "Arrêt des processus Syndra"

pkill -f "python.*main\.py" 2>/dev/null && _ok "python main.py arrêté" || _skip "python main.py"
pkill -f "syndrashell"      2>/dev/null && _ok "syndrashell arrêté"    || _skip "syndrashell"
pkill -f "awww init"      2>/dev/null && _ok "awww init arrêté"    || _skip "awww init"
sleep 0.5

# ── 2. Fichiers Syndra ───────────────────────────────────────────────
_step "2/5" "Suppression de Syndra Shell"

rm_safe "$INSTALL_DIR"                                   "SyndraShell (~/.config/SyndraShell)"
rm_safe "$HOME/.cache/syndrashell"                       "Cache (~/.cache/syndrashell)"
rm_safe "$HOME/.current.wall"                            "Wallpaper actuel (~/.current.wall)"
rm_safe "$HOME/.config/autostart/syndrashell.desktop"    "Autostart desktop"
rm_safe "$HOME/.config/systemd/user/syndrashell.service" "Service systemd"
systemctl --user daemon-reload 2>/dev/null || true

# ── 3. Polices ───────────────────────────────────────────────────────
_step "3/5" "Suppression des polices"

rm_safe "$HOME/.local/share/fonts/tabler-icons" "tabler-icons (~/.local/share/fonts)"
rm_safe "$HOME/.fonts/tabler-icons"             "tabler-icons (~/.fonts)"
fc-cache -f 2>/dev/null && _ok "Cache polices mis à jour" || true

# ── 4. Configurations liées ──────────────────────────────────────────
_step "4/5" "Suppression des configurations liées"

# Hyprland : seulement si c'est un lien symbolique (créé par install.sh)
# Si c'est un vrai fichier (config perso), on demande
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
if [ -L "$HYPR_CONF" ]; then
    rm_safe "$HYPR_CONF" "hyprland.conf (lien symbolique)"
elif [ -f "$HYPR_CONF" ]; then
    echo ""
    read -rp "  hyprland.conf est un fichier réel (pas un lien). Le supprimer ? [y/N] : " DEL_HYPR
    [[ "$DEL_HYPR" =~ ^[Yy]$ ]] && rm_safe "$HYPR_CONF" "hyprland.conf" || _skip "hyprland.conf (conservé)"
fi

# Configs liées par install.sh (liens symboliques uniquement)
for conf in waybar kitty wofi dunst; do
    TARGET="$HOME/.config/$conf"
    if [ -L "$TARGET" ]; then
        rm_safe "$TARGET" "$conf (lien symbolique)"
    else
        _skip "$conf (config personnelle conservée)"
    fi
done

# ── 5. Docker (conteneurs Syndra) + Hyprland si --full ───────────────
_step "5/5" "Nettoyage final"

if command -v docker &>/dev/null; then
    SYNDRA_CONTAINERS=$(docker ps -a --filter "name=syndra-" --format "{{.Names}}" 2>/dev/null)
    if [ -n "$SYNDRA_CONTAINERS" ]; then
        echo "$SYNDRA_CONTAINERS" | xargs docker rm -f 2>/dev/null && \
            _ok "Conteneurs Docker Syndra supprimés" || _warn "Suppression conteneurs échouée"
    else
        _skip "Conteneurs Docker Syndra"
    fi
    # Espace Docker récupéré
    rm_safe "$HOME/syndra-workspace" "syndra-workspace"
fi

if $FULL_REMOVE; then
    echo ""
    echo -e "  ${Y}${B}[--full] Suppression de Hyprland...${R}"
    if command -v pacman &>/dev/null; then
        sudo pacman -Rns --noconfirm hyprland hyprlock hypridle 2>/dev/null && \
            _ok "Hyprland désinstallé" || _warn "Désinstallation Hyprland partielle"
    fi
    if command -v docker &>/dev/null; then
        SYNDRA_IMAGES=$(docker images --filter "reference=*syndra*" --format "{{.ID}}" 2>/dev/null)
        [ -n "$SYNDRA_IMAGES" ] && \
            echo "$SYNDRA_IMAGES" | xargs docker rmi -f 2>/dev/null && _ok "Images Docker Syndra supprimées"
    fi
fi

# ── Résumé ────────────────────────────────────────────────────────────
echo ""
echo -e "${G}${B}"
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║      ✅  SYNDRA SHELL DÉSINSTALLÉ                        ║"
echo "  ╠══════════════════════════════════════════════════════════╣"
echo "  ║  Vos wallpapers ~/Pictures/Wallpapers sont conservés.    ║"
echo "  ║                                                           ║"
echo "  ║  Pour réinstaller :                                       ║"
echo "  ║  bash <(curl -sL https://raw.githubusercontent.com/      ║"
echo "  ║    Fud0o0/Syndra/main/install.sh) blue-team              ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo -e "${R}"
