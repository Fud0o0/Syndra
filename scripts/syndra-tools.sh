#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║   syndra-tools — lanceur d'outils conteneurisés par profil       ║
# ╚══════════════════════════════════════════════════════════════════╝
#
#   syndra-tools              → liste les outils du profil actif
#   syndra-tools pull         → télécharge toutes les images du profil
#   syndra-tools <outil> ...  → lance l'outil (ex: syndra-tools nmap -sV 10.0.0.1)
#   syndra-tools shell        → shell Kali avec /workspace monté
#   syndra-tools customize    → (profil custom) choisir ses outils
#   syndra-tools catalog      → liste TOUS les outils disponibles
#
# Fichiers partagés via ~/syndra-workspace ↔ /workspace dans les conteneurs.

set -uo pipefail

CONFIG_JSON="$HOME/.config/SyndraShell/config/config.json"
CUSTOM_CONF="$HOME/.config/SyndraShell/custom-tools.conf"
WORKSPACE="$HOME/syndra-workspace"
KALI="kalilinux/kali-rolling"
mkdir -p "$WORKSPACE"

R="\033[0m"; B="\033[1m"; G="\033[0;32m"; Y="\033[0;33m"; C="\033[0;36m"; E="\033[0;31m"

_read_profile() {
    python3 -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
    || python -c "import json;print(json.load(open('$CONFIG_JSON')).get('syndra_profile','default'))" 2>/dev/null \
    || echo "default"
}
PROFILE=$(_read_profile)

DOCKER="docker"
ensure_docker() {
    docker info &>/dev/null && { DOCKER="docker"; return 0; }
    sudo systemctl start docker 2>/dev/null || true
    if sudo docker info &>/dev/null; then DOCKER="sudo docker"; return 0; fi
    echo -e "${E}Docker inaccessible. Essaie: sudo systemctl start docker (ou reconnecte-toi pour le groupe docker).${R}"
    exit 1
}

# ── CATALOGUE COMPLET ───────────────────────────────────────────────
# Format : nom|image|flags|pkg|bin|description
#   image = "kali"  → kalilinux/kali-rolling, installe 'pkg', lance 'bin'
#   flags : NET (réseau hôte), GUI (affichage), IT (interactif)
catalog() {
cat <<EOF
nmap|instrumentisto/nmap|NET IT||nmap|Scanner de ports & services
rustscan|rustscan/rustscan:latest|NET IT|||Scanner de ports ultra-rapide
masscan|kali|NET IT|masscan|masscan|Scanner de ports masse
nikto|kali|NET IT|nikto|nikto|Scanner de vulnérabilités web
sqlmap|kali|NET IT|sqlmap|sqlmap|Injection SQL automatisée
gobuster|kali|NET IT|gobuster|gobuster|Brute-force répertoires/DNS
ffuf|kali|NET IT|ffuf|ffuf|Fuzzing web rapide
feroxbuster|kali|NET IT|feroxbuster|feroxbuster|Brute-force contenu web
wpscan|wpscanteam/wpscan|NET IT|||Scanner WordPress
nuclei|projectdiscovery/nuclei:latest|NET IT|||Scanner vuln. par templates
whatweb|kali|NET IT|whatweb|whatweb|Fingerprint technologies web
zap|zaproxy/zap-stable|GUI NET||zap.sh|Proxy d'audit web (OWASP ZAP)
metasploit|metasploitframework/metasploit-framework|NET IT||./msfconsole|Framework d'exploitation
hydra|kali|NET IT|hydra|hydra|Brute-force authentification
john|kali|IT|john|john|Cassage de mots de passe
hashcat|dizcza/docker-hashcat:intel-cpu|IT||hashcat|Cassage de hash (CPU)
wireshark|lscr.io/linuxserver/wireshark:latest|GUI NET|||Analyse réseau (GUI)
tshark|kali|NET IT|tshark|tshark|Analyse réseau (CLI)
tcpdump|kali|NET IT|tcpdump|tcpdump|Capture de paquets
suricata|jasonish/suricata:latest|NET IT||suricata|IDS/IPS réseau
zeek|zeek/zeek:latest|NET IT||zeek|Analyse trafic réseau
clamav|clamav/clamav:stable|IT||clamscan|Antivirus
trivy|aquasec/trivy:latest|IT|||Scanner vuln. conteneurs/FS
grype|anchore/grype:latest|IT|||Scanner vuln. images/FS
lynis|kali|IT|lynis|lynis|Audit de sécurité système
radare2|kali|IT|radare2|r2|Reverse engineering
gdb|kali|IT|gdb-multiarch|gdb-multiarch|Débogueur
ghidra|blacktop/ghidra:latest|GUI||ghidra|Reverse engineering (NSA)
binwalk|kali|IT|binwalk|binwalk|Analyse de firmware
steghide|kali|IT|steghide|steghide|Stéganographie
exiftool|kali|IT|libimage-exiftool-perl|exiftool|Métadonnées fichiers
foremost|kali|IT|foremost|foremost|Récupération de données
volatility3|sk4la/volatility3:latest|IT|||Analyse mémoire (forensics)
theharvester|kali|NET IT|theharvester|theHarvester|OSINT emails/sous-domaines
dnsrecon|kali|NET IT|dnsrecon|dnsrecon|Reconnaissance DNS
kali|kalilinux/kali-rolling|NET IT||/bin/bash|Shell Kali complet
EOF
}

# Récupère une ligne catalogue par nom d'outil
catalog_line() { catalog | grep "^${1}|" | head -1; }

# ── Listes d'outils par profil ──────────────────────────────────────
profile_tool_names() {
    case "$1" in
        blue-team) echo "nmap tshark tcpdump wireshark suricata zeek clamav trivy grype lynis nuclei" ;;
        red-team)  echo "kali nmap rustscan metasploit nikto sqlmap gobuster ffuf feroxbuster wpscan nuclei whatweb hydra john hashcat" ;;
        purple)    echo "kali nmap rustscan metasploit nikto sqlmap gobuster nuclei wpscan hydra john hashcat wireshark tshark suricata clamav trivy zap" ;;
        root-me)   echo "kali nmap radare2 gdb ghidra binwalk steghide exiftool foremost volatility3 john hashcat sqlmap hydra" ;;
        custom)
            if [ -f "$CUSTOM_CONF" ]; then
                tr '\n' ' ' < "$CUSTOM_CONF"
            else
                echo "kali nmap"
            fi
            ;;
        *)         echo "kali nmap" ;;
    esac
}

# Manifeste résolu (lignes catalogue) pour un profil
tools_for_profile() {
    for t in $(profile_tool_names "$1"); do
        catalog_line "$t"
    done
}

# ── Affichage ───────────────────────────────────────────────────────
do_list() {
    echo -e "${C}${B}Outils — profil: ${PROFILE}${R}\n"
    while IFS='|' read -r name image flags pkg bin desc; do
        [ -z "$name" ] && continue
        printf "  ${G}%-13s${R} %s\n" "$name" "$desc"
    done < <(tools_for_profile "$PROFILE")
    echo ""
    echo -e "  ${B}syndra-tools <outil> [args]${R}  ·  ${B}shell${R}  ·  ${B}pull${R}  ·  ${B}catalog${R}  ·  ${B}update${R}"
    [ "$PROFILE" = "custom" ] && echo -e "  ${B}syndra-tools customize${R}      → choisir tes outils"
    echo -e "  Workspace partagé : ${WORKSPACE} → /workspace"
}

do_catalog() {
    echo -e "${C}${B}Catalogue complet des outils${R}\n"
    local i=1
    while IFS='|' read -r name image flags pkg bin desc; do
        [ -z "$name" ] && continue
        printf "  ${G}%-14s${R} %s\n" "$name" "$desc"
    done < <(catalog)
}

# ── Pull images ─────────────────────────────────────────────────────
do_pull() {
    ensure_docker
    echo -e "${C}Téléchargement des images pour '${PROFILE}'...${R}"
    local seen=""
    while IFS='|' read -r name image flags pkg bin desc; do
        [ -z "$image" ] && continue
        [ "$image" = "kali" ] && image="$KALI"
        echo "$seen" | grep -qF "$image" && continue
        seen="$seen $image"
        echo -e "  ${C}→${R} $image"
        $DOCKER pull "$image" >/dev/null 2>&1 && echo -e "  ${G}✓${R} $image" || echo -e "  ${Y}⚠ $image${R}"
    done < <(tools_for_profile "$PROFILE")
    echo -e "${G}Terminé.${R}"
}

# ── Lancer un outil ─────────────────────────────────────────────────
run_tool() {
    ensure_docker
    local target="$1"; shift
    local line; line=$(catalog_line "$target")
    if [ -z "$line" ]; then
        echo -e "${E}Outil '${target}' inconnu.${R} Vois : syndra-tools catalog"
        exit 1
    fi
    IFS='|' read -r name image flags pkg bin desc <<< "$line"

    local args=(--rm)
    [[ "$flags" == *IT* ]]  && args+=(-it)
    [[ "$flags" == *NET* ]] && args+=(--net=host)
    args+=(-v "$WORKSPACE:/workspace" -w /workspace)
    if [[ "$flags" == *GUI* ]]; then
        args+=(-e "DISPLAY=${DISPLAY:-:0}" -v /tmp/.X11-unix:/tmp/.X11-unix \
               --cap-add=NET_ADMIN --cap-add=NET_RAW -e PUID=1000 -e PGID=1000)
        xhost +local: &>/dev/null || true
    fi

    echo -e "${C}▶ ${name} (${desc})${R}"
    if [ "$image" = "kali" ]; then
        if [ "$#" -eq 0 ] && [ "$bin" != "/bin/bash" ]; then
            # Sans argument : installe l'outil puis ouvre un SHELL interactif
            # → l'outil reste dispo, tu l'utilises autant que tu veux ('exit' pour sortir)
            echo -e "${Y}Installation de ${bin}… puis shell interactif (tape 'exit' pour quitter)${R}"
            $DOCKER run "${args[@]}" "$KALI" bash -c \
                'b="$1"; p="$2"; command -v "$b" >/dev/null 2>&1 || { apt-get update -qq >/dev/null 2>&1; apt-get install -y -qq "$p" >/dev/null 2>&1; }; echo -e "\033[0;32m✓ $b prêt.\033[0m Exemple: $b --help"; exec bash' \
                _ "$bin" "$pkg"
        else
            # Avec arguments : exécution unique (pratique pour scripter)
            $DOCKER run "${args[@]}" "$KALI" bash -c \
                'b="$1"; p="$2"; shift 2; command -v "$b" >/dev/null 2>&1 || { apt-get update -qq >/dev/null 2>&1; apt-get install -y -qq "$p" >/dev/null 2>&1; }; exec "$b" "$@"' \
                _ "$bin" "$pkg" "$@"
        fi
    elif [ -n "$bin" ]; then
        # shellcheck disable=SC2086
        $DOCKER run "${args[@]}" "$image" $bin "$@"
    else
        $DOCKER run "${args[@]}" "$image" "$@"
    fi
}

# ── Mise à jour ─────────────────────────────────────────────────────
do_update() {
    local repo="$HOME/.config/SyndraShell"
    echo -e "${C}${B}Mise à jour de Syndra…${R}"
    if [ -d "$repo/.git" ]; then
        echo -e "  ${C}→${R} git pull"
        if git -C "$repo" pull --ff-only 2>&1 | sed 's/^/    /'; then
            echo -e "  ${G}✓${R} dépôt à jour ($(git -C "$repo" log -1 --format='%h %s' 2>/dev/null))"
        else
            echo -e "  ${Y}⚠ git pull a échoué (modifications locales ?)${R}"
        fi
    else
        echo -e "  ${Y}⚠ dépôt git introuvable dans $repo${R}"
    fi
    # Recopier le lanceur
    local src="$repo/scripts/syndra-tools.sh"
    local dst="$HOME/.local/bin/syndra-tools"
    if [ -f "$src" ]; then
        mkdir -p "$HOME/.local/bin"
        cp "$src" "$dst" && chmod +x "$dst"
        echo -e "  ${G}✓${R} lanceur mis à jour → $dst"
    fi
    echo -e "${G}Terminé.${R}"
}

# ── Personnalisation (profil custom) ────────────────────────────────
do_customize() {
    echo -e "${C}${B}Personnalisation des outils — profil custom${R}\n"
    local names=() i=1
    while IFS='|' read -r name image flags pkg bin desc; do
        [ -z "$name" ] && continue
        names+=("$name")
        printf "  ${G}%2d${R}) %-14s %s\n" "$i" "$name" "$desc"
        i=$((i+1))
    done < <(catalog)
    echo ""
    echo -e "Entre les numéros séparés par des espaces (ex: 1 5 12), ou ${B}all${R} :"
    read -r sel
    : > "$CUSTOM_CONF"
    if [ "$sel" = "all" ]; then
        printf '%s\n' "${names[@]}" > "$CUSTOM_CONF"
    else
        for n in $sel; do
            idx=$((n-1))
            [ "$idx" -ge 0 ] 2>/dev/null && [ -n "${names[$idx]:-}" ] && echo "${names[$idx]}" >> "$CUSTOM_CONF"
        done
    fi
    # Toujours inclure le shell kali
    grep -qx "kali" "$CUSTOM_CONF" 2>/dev/null || echo "kali" >> "$CUSTOM_CONF"
    echo -e "\n${G}Outils enregistrés :${R} $(tr '\n' ' ' < "$CUSTOM_CONF")"
    echo -e "Télécharge-les avec : ${B}syndra-tools pull${R}"
}

# ── Dispatch ────────────────────────────────────────────────────────
if [ "${1:-}" = "__manifest" ]; then
    PROFILE="${2:-default}"; tools_for_profile "$PROFILE"; exit 0
fi
if [ "${1:-}" = "__names" ]; then
    profile_tool_names "${2:-default}"; exit 0
fi
if [ "${1:-}" = "__catalog" ]; then
    catalog; exit 0
fi

case "${1:-list}" in
    list|"")    do_list ;;
    catalog)    do_catalog ;;
    pull)       do_pull ;;
    update)     do_update ;;
    shell)      run_tool kali ;;
    customize)  do_customize ;;
    *)          run_tool "$@" ;;
esac
