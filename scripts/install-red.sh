#!/bin/bash
# Syndra Installation Script - Red Team Edition
# Offensive security focused installation

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    SYNDRA - RED TEAM                          ║"
echo "║              Offensive Security Environment                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: This script requires Arch Linux"
    exit 1
fi

# Display disk space information
REQUIRED_SPACE_GB=15
AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Espace requis: ${REQUIRED_SPACE_GB} GB"
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
echo "🔴 Installing Red Team tools and configuration..."

# Update system
sudo pacman -Syu --noconfirm

# Install base tools
echo "📦 Installing base tools..."
sudo pacman -S --noconfirm git base-devel wget curl python python-pip \
    python-virtualenv nodejs npm go rust

# Install Hyprland and Wayland essentials
echo "🎨 Installing Hyprland environment..."
sudo pacman -S --noconfirm hyprland waybar wofi kitty dunst \
    polkit-gnome xdg-desktop-portal-hyprland qt5-wayland qt6-wayland mpv

# Install mpvpaper for video wallpapers
echo "🎬 Installing mpvpaper for video wallpapers..."
yay -S --noconfirm mpvpaper

# Install Red Team security tools
echo "🔨 Installing Red Team offensive tools..."
sudo pacman -S --noconfirm nmap masscan wireshark-cli tcpdump \
    hashcat john aircrack-ng hydra sqlmap nikto metasploit \
    burpsuite zaproxy gobuster ffuf wfuzz dirb exploitdb \
    binwalk foremost steghide exiftool radare2 gdb ghidra

# Install additional pentesting tools via pip
echo "🐍 Installing Python security tools..."
pip install --user impacket crackmapexec bloodhound pwntools \
    scapy paramiko requests beautifulsoup4 lxml

# Install AUR helper (yay)
if ! command -v yay &> /dev/null; then
    echo "📦 Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install additional tools from AUR
echo "🌟 Installing AUR tools..."
yay -S --noconfirm sublister maltego feroxbuster nuclei subfinder \
    amass httpx waybackurls gau

# Clone Syndra configuration
echo "⚙️ Installing Syndra configuration..."
cd ~
if [ -d "SyndraShell" ]; then
    cd SyndraShell
    git pull
else
    git clone https://github.com/Fud0o0/Syndra.git SyndraShell
    cd SyndraShell
fi

# Copy configuration files
echo "📝 Applying Red Team configuration..."
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,dunst}
mkdir -p ~/Pictures/Wallpapers

# Copy default wallpaper if exists
if [ -f assets/wallpapers/default.mp4 ]; then
    echo "🖼️  Installing default wallpaper..."
    cp assets/wallpapers/default.mp4 ~/Pictures/Wallpapers/default.mp4
fi

cp -r config/hypr/* ~/.config/hypr/ 2>/dev/null || true
cp -r config/waybar/* ~/.config/waybar/ 2>/dev/null || true
cp -r config/wofi/* ~/.config/wofi/ 2>/dev/null || true
cp -r config/kitty/* ~/.config/kitty/ 2>/dev/null || true
cp -r config/dunst/* ~/.config/dunst/ 2>/dev/null || true

# Set Red Team color scheme
sed -i 's/--primary: #.*/--primary: #ff0066;/' ~/.config/waybar/style.css 2>/dev/null || true

# Install Python modules for Syndra
echo "🐍 Installing Syndra Python dependencies..."
pip install --user -r requirements.txt

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

# Calculate final disk usage
END_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
USED_SPACE=$((END_SIZE - START_SIZE))
AVAILABLE_NOW=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              ✅ RED TEAM INSTALLATION COMPLETE!               ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé par l'installation: ${USED_SPACE} GB              ║"
echo "║  💿 Espace disque total utilisé: ${END_SIZE} GB                   ║"
echo "║  📊 Espace disponible restant: ${AVAILABLE_NOW} GB               ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Next steps:                                                  ║"
echo "║  1. Logout and select Hyprland as your session                ║"
echo "║  2. Run: python ~/SyndraShell/main.py                         ║"
echo "║  3. Enjoy your Red Team offensive security environment!       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
