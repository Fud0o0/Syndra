#!/bin/bash
# Syndra Base Installation Script
# Installs core Hyprland environment and Syndra Shell interface
# This should be run BEFORE any team-specific installation

set -e          # Exit immediately if a command fails
set -u          # Treat unset variables as errors
set -o pipefail # Prevent errors in a pipeline from being masked

REPO_URL="https://github.com/Fud0o0/Syndra.git"
INSTALL_DIR="$HOME/.config/SyndraShell"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                 SYNDRA BASE INSTALLATION                      ║"
echo "║          Core Interface & Hyprland Environment                ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: This script requires Arch Linux"
    exit 1
fi

# Display disk space information
REQUIRED_SPACE_GB=5
AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Espace requis (base): ${REQUIRED_SPACE_GB} GB"
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

# Clone or update repository
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📦 Cloning Syndra repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
else
    echo "🔄 Syndra already exists, updating..."
    cd "$INSTALL_DIR" && git pull
fi

cd "$INSTALL_DIR"

# Install system dependencies (Core Hyprland + Wayland packages)
echo "🎨 Installing Hyprland and Wayland essentials..."

CORE_PACKAGES=(
  python-fabric-git
  fabric-cli-git
  matugen
  hyprland
  hypridle
  hyprlock
  brightnessctl
  networkmanager
  python-gobject
  python-pywayland
  wl-clipboard
  kitty
  wofi
  swww
  swaybg
  mpv
)

INTERFACE_PACKAGES=(
  waybar
  dunst
  network-manager-applet
  playerctl
  cliphist
  polkit-gnome
  xdg-desktop-portal-hyprland
  qt5-wayland
  qt6-wayland
)

TOOLS_PACKAGES=(
  hyprshot
  hyprpicker
  imagemagick
  gpu-screen-recorder
  tesseract
  swappy
)

# Check and install AUR helper if not present
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "📦 Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$INSTALL_DIR"
fi

AUR_HELPER=$(command -v yay || command -v paru)

echo "📦 Installing core Hyprland packages..."
$AUR_HELPER -S --needed --noconfirm "${CORE_PACKAGES[@]}" || echo "⚠️  Some core packages failed to install"

echo "📦 Installing interface packages..."
$AUR_HELPER -S --needed --noconfirm "${INTERFACE_PACKAGES[@]}" || echo "⚠️  Some interface packages failed to install"

echo "📦 Installing utility tools..."
$AUR_HELPER -S --needed --noconfirm "${TOOLS_PACKAGES[@]}" || echo "⚠️  Some tool packages failed to install (this is OK)"

# Install mpvpaper for video wallpapers
echo "🎬 Installing mpvpaper for video wallpapers..."
$AUR_HELPER -S --noconfirm mpvpaper || echo "⚠️  mpvpaper failed to install"

# Install Python dependencies
echo "🐍 Installing Python dependencies for Syndra..."
if [ -f "requirements.txt" ]; then
    pip install --user --break-system-packages -r requirements.txt
fi

# Create configuration directories
echo "📁 Creating configuration directories..."
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"/{hypr,waybar,wofi,kitty,dunst}
mkdir -p ~/Pictures/{Wallpapers,Screenshots}
mkdir -p ~/Videos/Recordings

# Create symbolic links for configurations
echo "🔗 Creating configuration links..."

# Hyprland
if [ ! -f "$CONFIG_DIR/hypr/hyprland.conf" ]; then
    ln -sf "$INSTALL_DIR/config/hypr/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
fi

# Add Syndra source line to Hyprland config if not already present
if ! grep -q "SyndraShell" "$CONFIG_DIR/hypr/hyprland.conf" 2>/dev/null; then
    echo "source = ~/.config/SyndraShell/config/hyprland/keybinds.conf" >> "$CONFIG_DIR/hypr/hyprland.conf"
fi

# Waybar
ln -sf "$INSTALL_DIR/config/waybar" "$CONFIG_DIR/waybar"

# Kitty
ln -sf "$INSTALL_DIR/config/kitty" "$CONFIG_DIR/kitty"

# Dunst
ln -sf "$INSTALL_DIR/config/dunst" "$CONFIG_DIR/dunst"

# Wofi
ln -sf "$INSTALL_DIR/config/wofi" "$CONFIG_DIR/wofi"

# Copy fonts if not already present
if [ ! -d "$HOME/.fonts/tabler-icons" ]; then
    echo "📝 Copying fonts..."
    mkdir -p "$HOME/.fonts"
    if [ -d "$INSTALL_DIR/assets/fonts" ]; then
        cp -r "$INSTALL_DIR/assets/fonts/"* "$HOME/.fonts"
        fc-cache -f
    fi
fi

# Create config from example if not exists
if [ ! -f "$INSTALL_DIR/config/config.json" ] && [ -f "$INSTALL_DIR/config.example.json" ]; then
    cp "$INSTALL_DIR/config.example.json" "$INSTALL_DIR/config/config.json"
    echo "📝 Created config.json from example"
fi

# Make scripts executable
echo "🔧 Setting script permissions..."
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null || true
chmod +x "$INSTALL_DIR/scripts/"*.py 2>/dev/null || true
chmod +x "$INSTALL_DIR/syndrashell.sh" 2>/dev/null || true
chmod +x "$INSTALL_DIR/main.py" 2>/dev/null || true

# Copy example wallpaper if wallpapers directory is empty
if [ -z "$(ls -A ~/Pictures/Wallpapers 2>/dev/null)" ]; then
    if [ -d "$INSTALL_DIR/assets/wallpapers" ]; then
        echo "🖼️  Copying example wallpapers..."
        cp -r "$INSTALL_DIR/assets/wallpapers/"* ~/Pictures/Wallpapers/ 2>/dev/null || true
    fi
fi

# Generate Hyprland configuration
echo "⚙️  Generating Syndra configuration..."
python "$INSTALL_DIR/config/settings_utils.py" 2>/dev/null || true

# Enable and start NetworkManager
if command -v systemctl &> /dev/null; then
    if ! systemctl is-enabled --quiet NetworkManager 2>/dev/null; then
        echo "🌐 Enabling NetworkManager..."
        sudo systemctl enable NetworkManager
    fi
    if ! systemctl is-active --quiet NetworkManager 2>/dev/null; then
        echo "🌐 Starting NetworkManager..."
        sudo systemctl start NetworkManager
    fi
fi

# Calculate disk usage
END_SIZE=$(df -BG / | tail -1 | awk '{print $3}' | sed 's/G//')
USED_SPACE=$((END_SIZE - START_SIZE))
AVAILABLE_NOW=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║           ✅ SYNDRA BASE INSTALLATION COMPLETE!               ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé: ${USED_SPACE} GB                                   ║"
echo "║  📊 Espace disponible: ${AVAILABLE_NOW} GB                           ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  L'interface Syndra Shell et l'environnement Hyprland        ║"
echo "║  sont maintenant installés!                                   ║"
echo "║                                                               ║"
echo "║  PROCHAINE ÉTAPE:                                            ║"
echo "║  Choisissez et lancez un script d'installation team:         ║"
echo "║    • ./scripts/install-blue.sh   (Defensive/Blue Team)       ║"
echo "║    • ./scripts/install-red.sh    (Offensive/Red Team)        ║"
echo "║    • ./scripts/install-purple.sh (Full Spectrum/Purple)      ║"
echo "║    • ./scripts/install-root.sh   (CTF/Root Me)               ║"
echo "║    • ./scripts/install-custom.sh (Custom configuration)      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
