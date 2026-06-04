#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║   syndra-tools — lanceur d'outils conteneurisés par profil       ║
# ╚══════════════════════════════════════════════════════════════════╝
#
#   syndra-tools            → liste les outils du profil actif
#   syndra-tools list       → idem
#   syndra-tools pull       → télécharge toutes les images du profil
#   syndra-tools <outil>    → lance l'outil (ex: syndra-tools nmap -sV ...)
#   syndra-tools shell      → ouvre un shell Kali avec /workspace monté
#
# Les fichiers sont partagés via ~/syndra-workspace (monté dans /workspace)

set -uo pipefail

CONFIG_JSON="$HOME/.config/SyndraShell/config/config.json"
WORKSPACE="$HOME/syndra-workspace"
mkdir -p "$WORKSPACE"

R="\033[0m"; B="\033[1m"; G="\033[0;32m"; Y="\033[0;33m"; C="\033[0;36m"; E="\033[0;31m"

# ── Profil actif ────────────────────────────────────────────────────
_read_profile() { python3 -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
    || python -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
    || echo "default"; }
PROFILE=$(_read_profile)

# Détection Docker paresseuse (appelée seulement quand on lance un conteneur)
DOCKER="docker"
ensure_docker() {
    docker info &>/dev/null && { DOCKER="docker"; return 0; }
    sudo systemctl start docker 2>/dev/null || true
    if sudo docker info &>/dev/null; then
        DOCKER="sudo docker"; return 0
    fi
    echo -e "${E}Docker inaccessible. Essaie: sudo systemctl start docker  (ou reconnecte-toi pour le groupe docker).${R}"
    exit 1
}

# ── Manifeste d'outils par profil ───────────────────────────────────
# Format par ligne : nom|image|flags_docker|commande
# flags spéciaux : NET=host, GUI, IT (interactif)
tools_for_profile() {
    case "$1" in
        blue-team)
            cat <<'EOF'
nmap|instrumentisto/nmap|NET IT|nmap
wireshark|lscr.io/linuxserver/wireshark:latest|GUI NET|
tshark|instrumentisto/nmap|NET IT|tshark
suricata|jasonish/suricata:latest|NET IT|suricata
clamav|clamav/clamav:stable|IT|clamscan
trivy|aquasec/trivy:latest|IT|trivy
EOF
            ;;
        red-team)
            cat <<'EOF'
kali|kalilinux/kali-rolling|NET IT|/bin/bash
metasploit|metasploitframework/metasploit-framework|NET IT|./msfconsole
nmap|instrumentisto/nmap|NET IT|nmap
sqlmap|kalilinux/kali-rolling|NET IT|bash -c "command -v sqlmap||apt update&&apt install -y sqlmap; sqlmap"
nikto|kalilinux/kali-rolling|NET IT|bash -c "command -v nikto||apt update&&apt install -y nikto; nikto"
hashcat|dizcza/docker-hashcat:intel-cpu|IT|hashcat
EOF
            ;;
        purple)
            cat <<'EOF'
kali|kalilinux/kali-rolling|NET IT|/bin/bash
metasploit|metasploitframework/metasploit-framework|NET IT|./msfconsole
nmap|instrumentisto/nmap|NET IT|nmap
wireshark|lscr.io/linuxserver/wireshark:latest|GUI NET|
suricata|jasonish/suricata:latest|NET IT|suricata
sqlmap|kalilinux/kali-rolling|NET IT|bash -c "command -v sqlmap||apt update&&apt install -y sqlmap; sqlmap"
hashcat|dizcza/docker-hashcat:intel-cpu|IT|hashcat
EOF
            ;;
        root-me)
            cat <<'EOF'
kali|kalilinux/kali-rolling|NET IT|/bin/bash
nmap|instrumentisto/nmap|NET IT|nmap
radare2|kalilinux/kali-rolling|IT|bash -c "command -v r2||apt update&&apt install -y radare2; r2"
gdb|kalilinux/kali-rolling|IT|bash -c "command -v gdb||apt update&&apt install -y gdb gdb-multiarch; gdb"
ctf|kalilinux/kali-rolling|NET IT|bash -c "apt update&&apt install -y binwalk foremost steghide exiftool john sqlmap nmap netcat-traditional radare2 gdb python3-pwntools 2>/dev/null; bash"
EOF
            ;;
        custom)
            cat <<'EOF'
kali|kalilinux/kali-rolling|NET IT|/bin/bash
nmap|instrumentisto/nmap|NET IT|nmap
EOF
            ;;
        *)
            cat <<'EOF'
kali|kalilinux/kali-rolling|NET IT|/bin/bash
EOF
            ;;
    esac
}

# ── Affichage liste ─────────────────────────────────────────────────
do_list() {
    echo -e "${C}${B}Outils conteneurisés — profil: ${PROFILE}${R}\n"
    printf "  %-14s %s\n" "OUTIL" "IMAGE"
    printf "  %-14s %s\n" "─────" "─────"
    while IFS='|' read -r name image flags cmd; do
        [ -z "$name" ] && continue
        printf "  ${G}%-14s${R} %s\n" "$name" "$image"
    done < <(tools_for_profile "$PROFILE")
    echo ""
    echo -e "  Usage : ${B}syndra-tools <outil> [args]${R}   (ex: syndra-tools nmap -sV 10.0.0.1)"
    echo -e "  Shell : ${B}syndra-tools shell${R}            (Kali avec /workspace monté)"
    echo -e "  Pull  : ${B}syndra-tools pull${R}             (télécharge toutes les images)"
    echo -e "  Fichiers partagés : ${WORKSPACE} → /workspace"
}

# ── Pull toutes les images ──────────────────────────────────────────
do_pull() {
    ensure_docker
    echo -e "${C}Téléchargement des images pour '${PROFILE}'...${R}"
    declare -A seen
    while IFS='|' read -r name image flags cmd; do
        [ -z "$image" ] && continue
        [ -n "${seen[$image]:-}" ] && continue
        seen[$image]=1
        echo -e "  ${C}→${R} $image"
        $DOCKER pull "$image" || echo -e "  ${Y}⚠ échec: $image${R}"
    done < <(tools_for_profile "$PROFILE")
    echo -e "${G}Terminé.${R}"
}

# ── Lancer un outil ─────────────────────────────────────────────────
run_tool() {
    ensure_docker
    local target="$1"; shift
    local line
    line=$(tools_for_profile "$PROFILE" | grep "^${target}|" | head -1)
    if [ -z "$line" ]; then
        echo -e "${E}Outil '${target}' non disponible pour le profil '${PROFILE}'.${R}"
        echo "Outils dispo :"; tools_for_profile "$PROFILE" | cut -d'|' -f1 | sed 's/^/  - /'
        exit 1
    fi
    IFS='|' read -r name image flags cmd <<< "$line"

    local docker_args=(--rm)
    [[ "$flags" == *IT* ]] && docker_args+=(-it)
    [[ "$flags" == *NET* ]] && docker_args+=(--net=host)
    docker_args+=(-v "$WORKSPACE:/workspace" -w /workspace)

    if [[ "$flags" == *GUI* ]]; then
        # App GUI Wayland/X — partage l'affichage
        docker_args+=(-e "DISPLAY=${DISPLAY:-:0}" -v /tmp/.X11-unix:/tmp/.X11-unix --cap-add=NET_ADMIN --cap-add=NET_RAW -e PUID=1000 -e PGID=1000)
        xhost +local: &>/dev/null || true
    fi

    echo -e "${C}▶ ${name} (${image})${R}"
    if [ -n "$cmd" ]; then
        # shellcheck disable=SC2086
        $DOCKER run "${docker_args[@]}" "$image" $cmd "$@"
    else
        $DOCKER run "${docker_args[@]}" "$image" "$@"
    fi
}

# ── Dispatch ────────────────────────────────────────────────────────
# __manifest <profil> : usage interne (install.sh) — sort le manifeste brut
if [ "${1:-}" = "__manifest" ]; then
    tools_for_profile "${2:-default}"
    exit 0
fi

case "${1:-list}" in
    list|"")      do_list ;;
    pull)         do_pull ;;
    shell)        run_tool kali ;;
    *)            run_tool "$@" ;;
esac
