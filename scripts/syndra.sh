#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║   syndra — commande principale de SyndraShell                    ║
# ╚══════════════════════════════════════════════════════════════════╝
#
#   syndra              bannière + aide
#   syndra update       met à jour Syndra (git pull + lanceurs)
#   syndra restart      redémarre l'interface
#   syndra reload       recharge la config Hyprland
#   syndra lock         verrouille la session
#   syndra status       état (profil, processus)
#   syndra tools [...]  raccourci vers syndra-tools
#   syndra version      version (commit) installé

set -uo pipefail

REPO="$HOME/.config/SyndraShell"
CONFIG_JSON="$REPO/config/config.json"
BIN="$HOME/.local/bin"

R="\033[0m"; B="\033[1m"; DIM="\033[2m"
G="\033[0;32m"; Y="\033[0;33m"; E="\033[0;31m"; W="\033[0;37m"

PROFILE=$(python3 -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
        || python -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
        || echo "default")

# Couleur d'accent selon le profil
case "$PROFILE" in
    blue-team) AC="\033[38;5;39m" ;;
    red-team)  AC="\033[38;5;196m" ;;
    purple)    AC="\033[38;5;141m" ;;
    root-me)   AC="\033[38;5;245m" ;;
    custom)    AC="\033[38;5;42m" ;;
    *)         AC="\033[38;5;75m" ;;
esac

banner() {
    echo ""
    echo -e "${AC}${B}    ⌁ SYNDRA${R}${DIM}  shell${R}"
    echo -e "${AC}    ╭─────────────────────────────╮${R}"
    printf  "${AC}    │${R}  profil : ${B}%-18s${R}${AC}│${R}\n" "$PROFILE"
    printf  "${AC}    │${R}  commit : ${DIM}%-18s${R}${AC}│${R}\n" "$(git -C "$REPO" log -1 --format='%h' 2>/dev/null || echo '—')"
    echo -e "${AC}    ╰─────────────────────────────╯${R}"
    echo ""
}

usage() {
    banner
    echo -e "  ${B}Commandes${R}"
    echo -e "    ${AC}syndra update${R}      met à jour Syndra (git + lanceurs)"
    echo -e "    ${AC}syndra restart${R}     redémarre l'interface"
    echo -e "    ${AC}syndra reload${R}      recharge la config Hyprland"
    echo -e "    ${AC}syndra lock${R}        verrouille la session"
    echo -e "    ${AC}syndra status${R}      état (profil, processus)"
    echo -e "    ${AC}syndra tools${R} [...] outils conteneurisés"
    echo -e "    ${AC}syndra version${R}     commit installé"
    echo ""
}

ok()   { echo -e "  ${G}✓${R} $1"; }
info() { echo -e "  ${AC}→${R} $1"; }
warn() { echo -e "  ${Y}⚠${R} $1"; }

cmd_update() {
    banner
    info "Mise à jour du dépôt…"
    if git -C "$REPO" pull --ff-only 2>&1 | sed 's/^/    /'; then
        ok "dépôt à jour ($(git -C "$REPO" log -1 --format='%h %s' 2>/dev/null))"
    else
        warn "git pull a échoué (modifications locales ?)"
    fi
    mkdir -p "$BIN"
    for f in syndra syndra-tools; do
        [ -f "$REPO/scripts/$f.sh" ] && cp "$REPO/scripts/$f.sh" "$BIN/$f" && chmod +x "$BIN/$f" && ok "lanceur $f mis à jour"
    done
    echo ""
    info "Relance l'interface avec : ${B}syndra restart${R}"
}

cmd_restart() {
    banner
    info "Redémarrage de l'interface…"
    pkill -f "python.*main\.py" 2>/dev/null && ok "ancienne instance arrêtée" || true
    sleep 0.5
    if [ -f "$REPO/syndrashell.sh" ]; then
        nohup bash "$REPO/syndrashell.sh" >/dev/null 2>&1 &
        ok "SyndraShell relancé"
    else
        warn "syndrashell.sh introuvable"
    fi
}

cmd_reload()  { info "hyprctl reload"; hyprctl reload >/dev/null 2>&1 && ok "config Hyprland rechargée" || warn "hyprctl indisponible"; }
cmd_lock()    { command -v hyprlock >/dev/null && hyprlock || warn "hyprlock non installé"; }
cmd_version() { echo -e "  SyndraShell ${B}$(git -C "$REPO" log -1 --format='%h %s' 2>/dev/null || echo 'inconnu')${R}"; }

cmd_status() {
    banner
    if pgrep -f "python.*main\.py" >/dev/null; then ok "interface : en cours"; else warn "interface : arrêtée"; fi
    if command -v awww >/dev/null && awww query >/dev/null 2>&1; then ok "fond d'écran : actif"; else warn "fond d'écran : inactif"; fi
    if command -v docker >/dev/null && docker info >/dev/null 2>&1; then ok "docker : disponible"; else warn "docker : indisponible"; fi
}

case "${1:-help}" in
    update)        cmd_update ;;
    restart)       cmd_restart ;;
    reload)        cmd_reload ;;
    lock)          cmd_lock ;;
    status)        cmd_status ;;
    version)       cmd_version ;;
    tools)         shift; exec "$BIN/syndra-tools" "$@" ;;
    help|-h|--help|"") usage ;;
    *)             warn "commande inconnue : $1"; usage; exit 1 ;;
esac
