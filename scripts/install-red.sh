#!/bin/bash
# Syndra Installation Script - Red Team Edition
# Offensive security tools installation
# REQUIRES: Syndra base installation (run install-syndra-base.sh first)

set -e

INSTALL_DIR="$HOME/.config/SyndraShell"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    SYNDRA - RED TEAM                          ║"
echo "║              Offensive Security Tools                         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if Syndra base is installed
if [ ! -d "$INSTALL_DIR" ]; then
    echo "❌ Erreur: Syndra base n'est pas installé!"
    echo "   Veuillez d'abord exécuter: ./scripts/install-syndra-base.sh"
    exit 1
fi

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ Erreur: Ce script nécessite Arch Linux"
    exit 1
fi

# Display disk space information
REQUIRED_SPACE_GB=10
AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Espace requis (outils Red Team): ${REQUIRED_SPACE_GB} GB"
echo "💿 Espace disponible: ${AVAILABLE_SPACE_GB} GB"

if [ "$AVAILABLE_SPACE_GB" -lt "$REQUIRED_SPACE_GB" ]; then
    echo "⚠️  Attention: Espace disque insuffisant!"
    read -p "Continuer quand même? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

START_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
echo "📊 Espace utilisé avant installation: ${START_SIZE} GB"
echo ""
echo "🔴 Installation des outils Red Team..."

# Update system
echo "🔄 Mise à jour du système..."
sudo pacman -Syu --noconfirm

# Install base development tools if not present
echo "📦 Installation des outils de développement de base..."
sudo pacman -S --needed --noconfirm git base-devel wget curl \
    python python-pip python-virtualenv nodejs npm go rust

# Install Red Team security tools
echo "🔨 Installation des outils offensifs Red Team..."
sudo pacman -S --needed --noconfirm nmap masscan wireshark-cli tcpdump \
    hashcat john aircrack-ng hydra sqlmap nikto metasploit \
    burpsuite zaproxy gobuster ffuf wfuzz dirb exploitdb \
    binwalk foremost steghide exiftool radare2 gdb ghidra || echo "⚠️  Certains outils ont échoué (continuons...)"

# Install additional pentesting tools via pip
echo "🐍 Installation des outils Python de pentest..."
pip install --user impacket crackmapexec bloodhound pwntools \
    scapy paramiko requests beautifulsoup4 lxml || echo "⚠️  Certains packages Python ont échoué"

# Check AUR helper
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "⚠️  AUR helper non trouvé. Certains packages AUR ne seront pas installés."
else
    AUR_HELPER=$(command -v yay || command -v paru)
    
    # Install additional tools from AUR
    echo "🌟 Installation des outils AUR..."
    $AUR_HELPER -S --needed --noconfirm sublister maltego feroxbuster nuclei subfinder \
        amass httpx waybackurls gau || echo "⚠️  Certains outils AUR ont échoué"
fi

# Configure Red Team color scheme
echo "🎨 Configuration du thème Red Team..."
if [ -f "$HOME/.config/waybar/style.css" ]; then
    sed -i 's/--primary: #.*/--primary: #ff0066;/' "$HOME/.config/waybar/style.css" 2>/dev/null || true
fi

# Start SyndraShell with Red Team configuration
echo "▶️  Démarrage de SyndraShell..."
cd "$INSTALL_DIR"
killall python 2>/dev/null || true
python "$INSTALL_DIR/main.py" >/dev/null 2>&1 &
disown

# Calculate final disk usage
END_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
USED_SPACE=$((END_SIZE - START_SIZE))
AVAILABLE_NOW=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║        ✅ INSTALLATION RED TEAM TERMINÉE!                     ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé: ${USED_SPACE} GB                                   ║"
echo "║  📊 Espace disponible: ${AVAILABLE_NOW} GB                           ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Outils Red Team installés:                                   ║"
echo "║  ✓ Nmap, Masscan (Network scanning)                          ║"
echo "║  ✓ Burp Suite, ZAP (Web security)                            ║"
echo "║  ✓ Metasploit, SQLMap (Exploitation)                         ║"
echo "║  ✓ Hashcat, John (Password cracking)                         ║"
echo "║  ✓ Ghidra, Radare2 (Reverse engineering)                     ║"
echo "║  ✓ Gobuster, ffuf (Fuzzing/Discovery)                        ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Prochaines étapes:                                           ║"
echo "║  1. Déconnectez-vous et sélectionnez Hyprland                ║"
echo "║  2. SyndraShell démarrera automatiquement                     ║"
echo "║  3. Appuyez sur SUPER+D pour le dashboard                     ║"
echo "║  4. Appuyez sur SUPER+R pour le lanceur d'applications       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

echo "║  3. Enjoy your Red Team offensive security environment!       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
