#!/bin/bash

set -e          # Exit immediately if a command fails
set -u          # Treat unset variables as errors
set -o pipefail # Prevent errors in a pipeline from being masked

REPO_URL="https://github.com/Fud0o0/Syndra.git"
INSTALL_DIR="$HOME/.config/SyndraShell"

echo "🚀 Installing SyndraShell..."

# Clone or update repository
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📦 Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
else
    echo "🔄 SyndraShell already installed, updating..."
    cd "$INSTALL_DIR" && git pull
fi

cd "$INSTALL_DIR"

# Install system dependencies (Arch Linux)
echo "📦 Installing system dependencies..."

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
)

TOOLS_PACKAGES=(
  hyprshot
  hyprpicker
  imagemagick
)

OPTIONAL_PACKAGES=(
  waybar
  dunst
  network-manager-applet
  playerctl
  cliphist
  gpu-screen-recorder
  tesseract
  swappy
)

# Check if running on Arch Linux
if command -v pacman &> /dev/null; then
    echo "Detected Arch Linux, installing dependencies..."
    # Install AUR helper if not present (yay or paru)
    if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
        echo "⚠️  AUR helper (yay or paru) not found. Please install one manually."
        echo "Some dependencies may need to be installed manually from AUR."
    else
        AUR_HELPER=$(command -v yay || command -v paru)
        
        echo "Installing core packages..."
        $AUR_HELPER -S --needed --noconfirm "${CORE_PACKAGES[@]}" || echo "⚠️  Some core packages failed to install"
        
        echo "Installing tools packages..."
        $AUR_HELPER -S --needed --noconfirm "${TOOLS_PACKAGES[@]}" || echo "⚠️  Some tool packages failed to install"
        
        echo "Installing optional packages..."
        $AUR_HELPER -S --needed --noconfirm "${OPTIONAL_PACKAGES[@]}" || echo "⚠️  Some optional packages failed to install (this is OK)"
    fi
else
    echo "⚠️  Not running Arch Linux. Please install dependencies manually."
fi

# Install Python dependencies
echo "📚 Installing Python dependencies..."
if [ -f "requirements.txt" ]; then
    pip install --user --break-system-packages -r requirements.txt
fi

# Create symbolic links for configurations
echo "🔗 Creating configuration links..."
CONFIG_DIR="$HOME/.config"

# Hyprland
mkdir -p "$CONFIG_DIR/hypr"
ln -sf "$INSTALL_DIR/config/hypr/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
echo "source = ~/.config/SyndraShell/config/hypr/syndrashell.conf" >> "$CONFIG_DIR/hypr/hyprland.conf" 2>/dev/null || true

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
    echo "📝 Copying local fonts..."
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

# Create directories
echo "📁 Creating directories..."
mkdir -p ~/Pictures/Wallpapers
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Videos/Recordings

# Copy example wallpaper if wallpapers directory is empty
if [ -z "$(ls -A ~/Pictures/Wallpapers)" ]; then
    if [ -f "$INSTALL_DIR/assets/wallpapers_example/example-1.jpg" ]; then
        echo "🖼️  Copying example wallpaper..."
        cp "$INSTALL_DIR/assets/wallpapers_example/example-1.jpg" ~/Pictures/Wallpapers/
    fi
fi

# Generate Hyprland configuration
echo "⚙️  Generating configuration..."
python "$INSTALL_DIR/config/settings_utils.py" 2>/dev/null || true

# Enable and start NetworkManager
if command -v systemctl &> /dev/null; then
    if ! systemctl is-enabled --quiet NetworkManager 2>/dev/null; then
        echo "Enabling NetworkManager..."
        sudo systemctl enable NetworkManager
    fi
    if ! systemctl is-active --quiet NetworkManager 2>/dev/null; then
        echo "Starting NetworkManager..."
        sudo systemctl start NetworkManager
    fi
fi

# Start SyndraShell
echo "▶️  Starting SyndraShell..."
killall syndrashell 2>/dev/null || true
uwsm app -- python "$INSTALL_DIR/main.py" >/dev/null 2>&1 &
disown

echo ""
echo "✅ SyndraShell installation complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Log out and log back into Hyprland"
echo "   2. Or reload Hyprland: hyprctl reload"
echo "   3. Press SUPER+D for dashboard"
echo "   4. Press SUPER+R for app launcher"
echo ""