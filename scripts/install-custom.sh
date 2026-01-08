#!/bin/bash
# Syndra Installation Script - Custom Edition
# Choose your own tools and configuration

set -e

# Colors - GREEN THEME
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo -e "${BRIGHT_GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BRIGHT_GREEN}║${NC}                   ${BOLD}SYNDRA - CUSTOM MODE${NC}                       ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}              ${GREEN}Build Your Own Security Environment${NC}              ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}❌ Error: This script requires Arch Linux${NC}"
    exit 1
fi

# Interactive component selection
echo -e "${CYAN}${BOLD}📦 Sélection des composants à installer${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

INSTALL_BASE=true
INSTALL_HYPRLAND=true

# Red Team tools
INSTALL_SCAN_TOOLS=false
INSTALL_EXPLOIT_TOOLS=false
INSTALL_WIRELESS_TOOLS=false
INSTALL_CRYPTO_TOOLS=false
INSTALL_FORENSICS_TOOLS=false
INSTALL_REVERSE_TOOLS=false
INSTALL_REDTEAM_PYTHON=false
INSTALL_REDTEAM_AUR=false

# Blue Team tools
INSTALL_MONITORING_TOOLS=false
INSTALL_DEFENSE_TOOLS=false
INSTALL_SIEM_TOOLS=false
INSTALL_FIREWALL=false
INSTALL_BLUETEAM_PYTHON=false
INSTALL_BLUETEAM_AUR=false

# Root Me / CTF tools
INSTALL_CTF_TOOLS=false
INSTALL_CTF_PYTHON=false
INSTALL_CTF_AUR=false
INSTALL_CTF_GDB=false

echo -e "${YELLOW}${BOLD}═══ COMPOSANTS DE BASE ═══${NC}"
echo ""

read -p "$(echo -e ${GREEN}\"[✓]${NC} Base tools (git, python, nodejs, rust) [Y/n]: \")" choice
[[ "$choice" =~ ^[Nn]$ ]] && INSTALL_BASE=false

read -p "$(echo -e ${GREEN}\"[✓]${NC} Hyprland Environment (waybar, wofi, kitty, dunst) [Y/n]: \")" choice
[[ "$choice" =~ ^[Nn]$ ]] && INSTALL_HYPRLAND=false

echo ""
echo -e "${RED}${BOLD}═══ RED TEAM - OFFENSIVE TOOLS ═══${NC}"
echo ""

read -p "$(echo -e ${GREEN}\"[1]${NC} Scanning tools (nmap, masscan, gobuster, ffuf, wfuzz) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_SCAN_TOOLS=true

read -p "$(echo -e ${GREEN}\"[2]${NC} Exploitation tools (metasploit, sqlmap, burpsuite, zaproxy) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_EXPLOIT_TOOLS=true

read -p "$(echo -e ${GREEN}\"[3]${NC} Wireless tools (aircrack-ng) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_WIRELESS_TOOLS=true

read -p "$(echo -e ${GREEN}\"[4]${NC} Crypto tools (hashcat, john) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_CRYPTO_TOOLS=true

read -p "$(echo -e ${GREEN}\"[5]${NC} Forensics tools (binwalk, foremost, steghide, exiftool) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_FORENSICS_TOOLS=true

read -p "$(echo -e ${GREEN}\"[6]${NC} Reverse engineering (radare2, gdb, ghidra) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_REVERSE_TOOLS=true

read -p "$(echo -e ${GREEN}\"[7]${NC} Python Red Team tools (impacket, pwntools, scapy) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_REDTEAM_PYTHON=true

read -p "$(echo -e ${GREEN}\"[8]${NC} AUR Red Team tools (sublister, nuclei, amass) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_REDTEAM_AUR=true

echo ""
echo -e "${CYAN}${BOLD}═══ BLUE TEAM - DEFENSIVE TOOLS ═══${NC}"
echo ""

read -p "$(echo -e ${GREEN}\"[9]${NC} Monitoring tools (wireshark, snort, suricata, zeek) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_MONITORING_TOOLS=true

read -p "$(echo -e ${GREEN}\"[10]${NC} Defense tools (fail2ban, aide, tripwire, lynis) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_DEFENSE_TOOLS=true

read -p "$(echo -e ${GREEN}\"[11]${NC} SIEM & Analysis (wazuh, osquery, elastalert) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_SIEM_TOOLS=true

read -p "$(echo -e ${GREEN}\"[12]${NC} Firewall configuration (ufw, iptables) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_FIREWALL=true

read -p "$(echo -e ${GREEN}\"[13]${NC} Python Blue Team tools (volatility3, yara, sigma) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_BLUETEAM_PYTHON=true

read -p "$(echo -e ${GREEN}\"[14]${NC} AUR Blue Team tools (wazuh-agent, osquery) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_BLUETEAM_AUR=true

echo ""
echo -e "${WHITE}${BOLD}═══ ROOT ME - CTF TOOLS ═══${NC}"
echo ""

read -p "$(echo -e ${GREEN}\"[15]${NC} CTF & Reverse tools (gdb, radare2, binwalk, ghidra) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_CTF_TOOLS=true

read -p "$(echo -e ${GREEN}\"[16]${NC} Python CTF tools (pwntools, angr, z3-solver) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_CTF_PYTHON=true

read -p "$(echo -e ${GREEN}\"[17]${NC} AUR CTF tools (pwndbg, gef, ropper, checksec) [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_CTF_AUR=true

read -p "$(echo -e ${GREEN}\"[18]${NC} GDB setup with pwndbg [y/N]: \")" choice
[[ "$choice" =~ ^[Yy]$ ]] && INSTALL_CTF_GDB=true

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Calculate estimated space
ESTIMATED_SPACE=2
[ "$INSTALL_BASE" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 3))
[ "$INSTALL_HYPRLAND" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 2))
[ "$INSTALL_SCAN_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 1))
[ "$INSTALL_EXPLOIT_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 4))
[ "$INSTALL_CRYPTO_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 2))
[ "$INSTALL_FORENSICS_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 1))
[ "$INSTALL_REVERSE_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 3))
[ "$INSTALL_MONITORING_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 3))
[ "$INSTALL_DEFENSE_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 2))
[ "$INSTALL_SIEM_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 2))
[ "$INSTALL_CTF_TOOLS" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 3))
[ "$INSTALL_CTF_PYTHON" = true ] && ESTIMATED_SPACE=$((ESTIMATED_SPACE + 2))

AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo -e "${CYAN}💾 Espace estimé requis: ${ESTIMATED_SPACE} GB${NC}"
echo -e "${CYAN}💿 Espace disponible: ${AVAILABLE_SPACE_GB} GB${NC}"

if [ "$AVAILABLE_SPACE_GB" -lt "$ESTIMATED_SPACE" ]; then
    echo -e "${YELLOW}⚠️  Attention: Espace disque potentiellement insuffisant!${NC}"
    read -p "Continuer quand même? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

START_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
echo -e "${CYAN}📊 Espace utilisé avant installation: ${START_SIZE} GB${NC}"
echo ""
echo -e "${BRIGHT_GREEN}🚀 Démarrage de l'installation personnalisée...${NC}"
echo ""

# Update system
echo -e "${GREEN}🔄 Mise à jour du système...${NC}"
sudo pacman -Syu --noconfirm

# Install base tools
if [ "$INSTALL_BASE" = true ]; then
    echo -e "${GREEN}📦 Installing base tools...${NC}"
    sudo pacman -S --noconfirm git base-devel wget curl python python-pip \
        python-virtualenv nodejs npm go rust
fi

# Install Hyprland
if [ "$INSTALL_HYPRLAND" = true ]; then
    echo -e "${GREEN}🎨 Installing Hyprland environment...${NC}"
    sudo pacman -S --noconfirm hyprland waybar wofi kitty dunst \
        polkit-gnome xdg-desktop-portal-hyprland qt5-wayland qt6-wayland mpv
    
    echo -e "${GREEN}🎬 Installing mpvpaper for video wallpapers...${NC}"
    yay -S --noconfirm mpvpaper
fi

# RED TEAM TOOLS
REDTEAM_PACKAGES=""

if [ "$INSTALL_SCAN_TOOLS" = true ]; then
    echo -e "${RED}🔍 Installing scanning tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES nmap masscan wireshark-cli tcpdump gobuster ffuf wfuzz dirb"
fi

if [ "$INSTALL_EXPLOIT_TOOLS" = true ]; then
    echo -e "${RED}💥 Installing exploitation tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES hydra sqlmap nikto metasploit burpsuite zaproxy exploitdb"
fi

if [ "$INSTALL_WIRELESS_TOOLS" = true ]; then
    echo -e "${RED}📡 Installing wireless tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES aircrack-ng"
fi

if [ "$INSTALL_CRYPTO_TOOLS" = true ]; then
    echo -e "${RED}🔐 Installing crypto tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES hashcat john"
fi

if [ "$INSTALL_FORENSICS_TOOLS" = true ]; then
    echo -e "${RED}🔬 Installing forensics tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES binwalk foremost steghide exiftool"
fi

if [ "$INSTALL_REVERSE_TOOLS" = true ]; then
    echo -e "${RED}🔧 Installing reverse engineering tools...${NC}"
    REDTEAM_PACKAGES="$REDTEAM_PACKAGES radare2 gdb ghidra"
fi

if [ -n "$REDTEAM_PACKAGES" ]; then
    sudo pacman -S --noconfirm $REDTEAM_PACKAGES
fi

# BLUE TEAM TOOLS
BLUETEAM_PACKAGES=""

if [ "$INSTALL_MONITORING_TOOLS" = true ]; then
    echo -e "${CYAN}👁️ Installing monitoring tools...${NC}"
    BLUETEAM_PACKAGES="$BLUETEAM_PACKAGES wireshark-qt snort suricata tcpdump tshark nmap"
fi

if [ "$INSTALL_DEFENSE_TOOLS" = true ]; then
    echo -e "${CYAN}🛡️ Installing defense tools...${NC}"
    BLUETEAM_PACKAGES="$BLUETEAM_PACKAGES aide rkhunter clamav chkrootkit lynis fail2ban tripwire"
fi

if [ "$INSTALL_FIREWALL" = true ]; then
    echo -e "${CYAN}🔥 Installing firewall tools...${NC}"
    BLUETEAM_PACKAGES="$BLUETEAM_PACKAGES ufw iptables nftables"
fi

if [ -n "$BLUETEAM_PACKAGES" ]; then
    sudo pacman -S --noconfirm $BLUETEAM_PACKAGES
fi

# CTF TOOLS
CTF_PACKAGES=""

if [ "$INSTALL_CTF_TOOLS" = true ]; then
    echo -e "${WHITE}🎯 Installing CTF tools...${NC}"
    CTF_PACKAGES="$CTF_PACKAGES gdb radare2 ghidra binwalk foremost strings ltrace strace hexedit"
    CTF_PACKAGES="$CTF_PACKAGES bless xxd file binutils gcc make cmake nasm yasm"
    CTF_PACKAGES="$CTF_PACKAGES openssl hashcat john steghide exiftool volatility"
fi

if [ -n "$CTF_PACKAGES" ]; then
    sudo pacman -S --noconfirm $CTF_PACKAGES
fi

# Python packages
if [ "$INSTALL_REDTEAM_PYTHON" = true ] || [ "$INSTALL_BLUETEAM_PYTHON" = true ] || [ "$INSTALL_CTF_PYTHON" = true ]; then
    echo -e "${GREEN}🐍 Installing Python security tools...${NC}"
    
    PYTHON_PACKAGES=""
    [ "$INSTALL_REDTEAM_PYTHON" = true ] && PYTHON_PACKAGES="$PYTHON_PACKAGES impacket crackmapexec bloodhound pwntools scapy paramiko"
    [ "$INSTALL_BLUETEAM_PYTHON" = true ] && PYTHON_PACKAGES="$PYTHON_PACKAGES volatility3 yara-python sigma-cli"
    [ "$INSTALL_CTF_PYTHON" = true ] && PYTHON_PACKAGES="$PYTHON_PACKAGES angr z3-solver capstone ropper"
    
    pip install --user $PYTHON_PACKAGES
fi

# Install AUR helper (yay) if needed
if [ "$INSTALL_REDTEAM_AUR" = true ] || [ "$INSTALL_BLUETEAM_AUR" = true ] || [ "$INSTALL_CTF_AUR" = true ]; then
    if ! command -v yay &> /dev/null; then
        echo -e "${GREEN}📦 Installing yay AUR helper...${NC}"
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
    fi
    
    AUR_PACKAGES=""
    [ "$INSTALL_REDTEAM_AUR" = true ] && AUR_PACKAGES="$AUR_PACKAGES sublister nuclei subfinder amass"
    [ "$INSTALL_BLUETEAM_AUR" = true ] && AUR_PACKAGES="$AUR_PACKAGES wazuh-agent osquery"
    [ "$INSTALL_CTF_AUR" = true ] && AUR_PACKAGES="$AUR_PACKAGES pwndbg gef ropper checksec"
    
    if [ -n "$AUR_PACKAGES" ]; then
        echo -e "${GREEN}🌟 Installing AUR tools...${NC}"
        yay -S --noconfirm $AUR_PACKAGES
    fi
fi

# Configure firewall if selected
if [ "$INSTALL_FIREWALL" = true ]; then
    echo -e "${CYAN}🔥 Configuring firewall...${NC}"
    sudo systemctl enable ufw
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw enable
fi

# Clone Syndra configuration
echo -e "${GREEN}⚙️ Installing Syndra configuration...${NC}"
cd ~
if [ -d "SyndraShell" ]; then
    cd SyndraShell
    git pull
else
    git clone https://github.com/Fud0o0/Syndra.git SyndraShell
    cd SyndraShell
fi

# Copy configuration files
echo -e "${GREEN}📝 Applying Custom configuration...${NC}"
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,dunst}
mkdir -p ~/Pictures/Wallpapers

# Copy default wallpaper if exists
if [ -f assets/wallpapers/default.mp4 ]; then
    echo -e "${GREEN}🖼️  Installing default wallpaper...${NC}"
    cp assets/wallpapers/default.mp4 ~/Pictures/Wallpapers/default.mp4
fi

cp -r config/hypr/* ~/.config/hypr/ 2>/dev/null || true
cp -r config/waybar/* ~/.config/waybar/ 2>/dev/null || true
cp -r config/wofi/* ~/.config/wofi/ 2>/dev/null || true
cp -r config/kitty/* ~/.config/kitty/ 2>/dev/null || true
cp -r config/dunst/* ~/.config/dunst/ 2>/dev/null || true

# Set Custom (green) color scheme
sed -i 's/--primary: #.*/--primary: #00ff66;/' ~/.config/waybar/style.css 2>/dev/null || true

# Install Python modules for Syndra
echo -e "${GREEN}🐍 Installing Syndra Python dependencies...${NC}"
pip install --user -r requirements.txt

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

# Setup GDB with pwndbg if CTF GDB selected
if [ "$INSTALL_CTF_GDB" = true ]; then
    echo -e "${WHITE}🔧 Configuring GDB with pwndbg...${NC}"
    cd ~
    if [ ! -d "pwndbg" ]; then
        git clone https://github.com/pwndbg/pwndbg
        cd pwndbg
        ./setup.sh
    fi
fi

# Calculate final disk usage
END_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
USED_SPACE=$((END_SIZE - START_SIZE))
AVAILABLE_NOW=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

echo ""
echo -e "${BRIGHT_GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BRIGHT_GREEN}║${NC}            ${BOLD}✅ CUSTOM INSTALLATION COMPLETE!${NC}              ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  💾 Espace utilisé par l'installation: ${USED_SPACE} GB              ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  💿 Espace disque total utilisé: ${END_SIZE} GB                   ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  📊 Espace disponible restant: ${AVAILABLE_NOW} GB               ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  Next steps:                                                  ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  1. Logout and select Hyprland as your session                ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  2. Run: python ~/SyndraShell/main.py                         ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}║${NC}  3. Enjoy your custom security environment!                   ${BRIGHT_GREEN}║${NC}"
echo -e "${BRIGHT_GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
