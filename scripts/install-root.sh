#!/bin/bash
# Syndra Installation Script - Root Me Edition
# CTF and challenge-focused installation

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    SYNDRA - ROOT ME                           ║"
echo "║              CTF & Challenge Environment                      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: This script requires Arch Linux"
    exit 1
fi

# Display disk space information
REQUIRED_SPACE_GB=18
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
echo "⚫ Installing Root Me CTF tools and configuration..."

# Update system
sudo pacman -Syu --noconfirm

# Install base tools
echo "📦 Installing base tools..."
sudo pacman -S --noconfirm git base-devel wget curl python python-pip \
    python-virtualenv nodejs npm go rust

# Install Hyprland and Wayland essentials
echo "🎨 Installing Hyprland environment..."
sudo pacman -S --noconfirm hyprland waybar wofi kitty dunst \
    polkit-gnome xdg-desktop-portal-hyprland qt5-wayland qt6-wayland

# Install CTF and reversing tools
echo "🎯 Installing CTF tools..."
sudo pacman -S --noconfirm gdb radare2 ghidra binwalk foremost strings \
    ltrace strace hexedit bless xxd file binutils gcc make cmake \
    nasm yasm gdb-multiarch qemu-user qemu-system-x86 \
    wireshark-cli tcpdump nmap masscan hashcat john

# Install crypto and forensics tools
echo "🔐 Installing crypto & forensics tools..."
sudo pacman -S --noconfirm openssl hashcat john steghide exiftool \
    volatility sleuthkit autopsy testdisk photorec

# Install web exploitation tools
echo "🌐 Installing web exploitation tools..."
sudo pacman -S --noconfirm burpsuite zaproxy sqlmap nikto gobuster \
    ffuf wfuzz dirb

# Install Python CTF frameworks and tools
echo "🐍 Installing Python CTF tools..."
pip install --user pwntools angr z3-solver capstone unicorn keystone-engine \
    ropper ropgadget pycryptodome gmpy2 sympy sage requests \
    beautifulsoup4 lxml scapy paramiko

# Install AUR helper (yay)
if ! command -v yay &> /dev/null; then
    echo "📦 Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install additional CTF tools from AUR
echo "🌟 Installing AUR CTF tools..."
yay -S --noconfirm pwndbg gef peda ropper checksec one_gadget \
    seccomp-tools pwninit ropstar

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
echo "📝 Applying Root Me configuration..."
mkdir -p ~/.config/{hypr,waybar,wofi,kitty,dunst}
cp -r config/hypr/* ~/.config/hypr/ 2>/dev/null || true
cp -r config/waybar/* ~/.config/waybar/ 2>/dev/null || true
cp -r config/wofi/* ~/.config/wofi/ 2>/dev/null || true
cp -r config/kitty/* ~/.config/kitty/ 2>/dev/null || true
cp -r config/dunst/* ~/.config/dunst/ 2>/dev/null || true

# Set Root Me (black & white) color scheme
sed -i 's/--primary: #.*/--primary: #ffffff;/' ~/.config/waybar/style.css 2>/dev/null || true

# Setup CTF workspace
echo "📁 Creating CTF workspace..."
mkdir -p ~/CTF/{tools,challenges,writeups}

# Clone useful CTF repositories
echo "📚 Cloning CTF resources..."
cd ~/CTF/tools
git clone https://github.com/Gallopsled/pwntools.git 2>/dev/null || true
git clone https://github.com/JonathanSalwan/ROPgadget.git 2>/dev/null || true
git clone https://github.com/longld/peda.git 2>/dev/null || true

# Install Python modules for Syndra
echo "🐍 Installing Syndra Python dependencies..."
cd ~/SyndraShell
pip install --user -r requirements.txt

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

# Setup GDB with pwndbg
echo "🔧 Configuring GDB with pwndbg..."
cd ~
if [ ! -d "pwndbg" ]; then
    git clone https://github.com/pwndbg/pwndbg
    cd pwndbg
    ./setup.sh
fi

# Calculate final disk usage
END_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
USED_SPACE=$((END_SIZE - START_SIZE))
AVAILABLE_NOW=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              ✅ ROOT ME INSTALLATION COMPLETE!                ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé par l'installation: ${USED_SPACE} GB              ║"
echo "║  💿 Espace disque total utilisé: ${END_SIZE} GB                   ║"
echo "║  📊 Espace disponible restant: ${AVAILABLE_NOW} GB               ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Next steps:                                                  ║"
echo "║  1. Logout and select Hyprland as your session                ║"
echo "║  2. Run: python ~/SyndraShell/main.py                         ║"
echo "║  3. Check ~/CTF/ for your CTF workspace                       ║"
echo "║  4. Enjoy your Root Me CTF challenge environment!             ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
