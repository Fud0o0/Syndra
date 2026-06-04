#!/bin/bash
# Syndra Installation Script - Root Me Edition
# CTF and challenge-focused tools installation
# REQUIRES: Syndra base installation (run install-syndra-base.sh first)

set -e

INSTALL_DIR="$HOME/.config/SyndraShell"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    SYNDRA - ROOT ME                           ║"
echo "║              CTF & Challenge Tools                            ║"
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
REQUIRED_SPACE_GB=7
AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Espace requis (outils CTF): ${REQUIRED_SPACE_GB} GB"
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
echo "⚫ Installation des outils CTF et Root Me..."

# Update system
echo "🔄 Mise à jour du système..."
sudo pacman -Syu --noconfirm

# Install base development tools if not present
echo "📦 Installation des outils de développement de base..."
sudo pacman -S --needed --noconfirm git base-devel wget curl \
    python python-pip python-virtualenv nodejs npm go rust

# Install CTF and reversing tools
echo "🎯 Installation des outils CTF et reverse engineering..."
sudo pacman -S --needed --noconfirm gdb radare2 ghidra binwalk foremost strings \
    ltrace strace hexedit bless xxd file binutils gcc make cmake \
    nasm yasm gdb-multiarch qemu-user qemu-system-x86 \
    wireshark-cli tcpdump nmap masscan hashcat john || echo "⚠️  Certains outils CTF ont échoué"

# Install crypto and forensics tools
echo "🔐 Installation des outils crypto & forensics..."
sudo pacman -S --needed --noconfirm openssl hashcat john steghide exiftool \
    volatility sleuthkit autopsy testdisk photorec || echo "⚠️  Certains outils forensics ont échoué"

# Install web exploitation tools
echo "🌐 Installation des outils web exploitation..."
sudo pacman -S --needed --noconfirm burpsuite zaproxy sqlmap nikto gobuster \
    ffuf wfuzz dirb || echo "⚠️  Certains outils web ont échoué"

# Install Python CTF frameworks and tools
echo "🐍 Installation des frameworks CTF Python..."
pip install --user pwntools angr z3-solver capstone unicorn keystone-engine \
    ropper ropgadget pycryptodome gmpy2 sympy requests \
    beautifulsoup4 lxml scapy paramiko || echo "⚠️  Certains packages Python ont échoué"

# Check AUR helper
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "⚠️  AUR helper non trouvé. Certains packages AUR ne seront pas installés."
else
    AUR_HELPER=$(command -v yay || command -v paru)
    
    # Install additional CTF tools from AUR
    echo "🌟 Installation des outils CTF depuis AUR..."
    $AUR_HELPER -S --needed --noconfirm pwndbg gef peda ropper checksec one_gadget \
        seccomp-tools pwninit ropstar || echo "⚠️  Certains outils AUR ont échoué"
fi

# Configure Root Me (black & white) color scheme
echo "🎨 Configuration du thème Root Me..."
if [ -f "$HOME/.config/waybar/style.css" ]; then
    sed -i 's/--primary: #.*/--primary: #ffffff;/' "$HOME/.config/waybar/style.css" 2>/dev/null || true
fi

# Setup CTF workspace
echo "📁 Création de l'espace de travail CTF..."
mkdir -p ~/CTF/{tools,challenges,writeups}

# Clone useful CTF repositories
echo "📚 Clonage des ressources CTF..."
cd ~/CTF/tools
git clone https://github.com/Gallopsled/pwntools.git 2>/dev/null || true
git clone https://github.com/JonathanSalwan/ROPgadget.git 2>/dev/null || true
git clone https://github.com/longld/peda.git 2>/dev/null || true

# Setup GDB with pwndbg
echo "🔧 Configuration de GDB avec pwndbg..."
cd ~
if [ ! -d "pwndbg" ]; then
    git clone https://github.com/pwndbg/pwndbg
    cd pwndbg
    ./setup.sh || echo "⚠️  Configuration pwndbg échouée"
fi

# Start SyndraShell with Root Me configuration
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
echo "║        ✅ INSTALLATION ROOT ME/CTF TERMINÉE!                  ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé: ${USED_SPACE} GB                                   ║"
echo "║  📊 Espace disponible: ${AVAILABLE_NOW} GB                           ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Outils CTF installés:                                        ║"
echo "║  ✓ Reverse: GDB, Radare2, Ghidra, pwndbg                     ║"
echo "║  ✓ Pwn: pwntools, ROPgadget, checksec                        ║"
echo "║  ✓ Crypto: OpenSSL, hashcat, john                            ║"
echo "║  ✓ Forensics: Volatility, Autopsy, binwalk                   ║"
echo "║  ✓ Web: Burp Suite, SQLMap, gobuster                         ║"
echo "║  ✓ Workspace CTF créé dans ~/CTF/                            ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Prochaines étapes:                                           ║"
echo "║  1. Déconnectez-vous et sélectionnez Hyprland                ║"
echo "║  2. SyndraShell démarrera automatiquement                     ║"
echo "║  3. Vos challenges CTF vont dans ~/CTF/challenges/            ║"
echo "║  4. Appuyez sur SUPER+D pour le dashboard                     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

echo "║  4. Enjoy your Root Me CTF challenge environment!             ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
