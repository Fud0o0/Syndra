#!/bin/bash
# Check SyndraShell dependencies
# Usage: bash scripts/check-dependencies.sh

echo "🔍 Checking SyndraShell Dependencies..."
echo ""

MISSING_CORE=()
MISSING_TOOLS=()
MISSING_OPTIONAL=()

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if Python package is installed
python_package_exists() {
    python -c "import $1" &> /dev/null
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "CORE DEPENDENCIES (Required)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Core Framework
if command_exists fabric; then
    echo "✅ Fabric framework"
else
    echo "❌ Fabric framework (python-fabric-git)"
    MISSING_CORE+=("python-fabric-git")
fi

if command_exists matugen; then
    echo "✅ Matugen"
else
    echo "❌ Matugen (matugen-bin)"
    MISSING_CORE+=("matugen-bin")
fi

# Hyprland
if command_exists Hyprland; then
    echo "✅ Hyprland"
else
    echo "❌ Hyprland"
    MISSING_CORE+=("hyprland")
fi

if command_exists hypridle; then
    echo "✅ Hypridle"
else
    echo "❌ Hypridle"
    MISSING_CORE+=("hypridle")
fi

if command_exists hyprlock; then
    echo "✅ Hyprlock"
else
    echo "❌ Hyprlock"
    MISSING_CORE+=("hyprlock")
fi

# System utilities
if command_exists brightnessctl; then
    echo "✅ brightnessctl"
else
    echo "❌ brightnessctl"
    MISSING_CORE+=("brightnessctl")
fi

if command_exists nmcli; then
    echo "✅ NetworkManager"
else
    echo "❌ NetworkManager"
    MISSING_CORE+=("networkmanager")
fi

if command_exists kitty; then
    echo "✅ Kitty terminal"
else
    echo "❌ Kitty terminal"
    MISSING_CORE+=("kitty")
fi

if command_exists wofi; then
    echo "✅ Wofi launcher"
else
    echo "❌ Wofi launcher"
    MISSING_CORE+=("wofi")
fi

if command_exists wl-copy; then
    echo "✅ wl-clipboard"
else
    echo "❌ wl-clipboard"
    MISSING_CORE+=("wl-clipboard")
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SCREENSHOT & TOOLS (Required)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command_exists hyprshot; then
    echo "✅ Hyprshot"
else
    echo "❌ Hyprshot"
    MISSING_TOOLS+=("hyprshot")
fi

if command_exists hyprpicker; then
    echo "✅ Hyprpicker"
else
    echo "❌ Hyprpicker"
    MISSING_TOOLS+=("hyprpicker")
fi

if command_exists magick; then
    echo "✅ ImageMagick"
else
    echo "❌ ImageMagick"
    MISSING_TOOLS+=("imagemagick")
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "OPTIONAL FEATURES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command_exists gpu-screen-recorder; then
    echo "✅ gpu-screen-recorder (screen recording)"
else
    echo "⚠️  gpu-screen-recorder (screen recording disabled)"
    MISSING_OPTIONAL+=("gpu-screen-recorder")
fi

if command_exists tesseract; then
    echo "✅ Tesseract (OCR)"
else
    echo "⚠️  Tesseract (OCR disabled)"
    MISSING_OPTIONAL+=("tesseract")
fi

if command_exists swappy; then
    echo "✅ Swappy (screenshot editing)"
else
    echo "⚠️  Swappy (screenshot editing disabled)"
    MISSING_OPTIONAL+=("swappy")
fi

if command_exists waybar; then
    echo "✅ Waybar (alternative bar)"
else
    echo "⚠️  Waybar (not used by default)"
    MISSING_OPTIONAL+=("waybar")
fi

if command_exists dunst; then
    echo "✅ Dunst (alternative notifications)"
else
    echo "⚠️  Dunst (not used by default)"
    MISSING_OPTIONAL+=("dunst")
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PYTHON DEPENDENCIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if python_package_exists gi; then
    echo "✅ PyGObject"
else
    echo "❌ PyGObject"
    MISSING_CORE+=("python-gobject")
fi

if python_package_exists PIL; then
    echo "✅ Pillow"
else
    echo "❌ Pillow"
    MISSING_CORE+=("Pillow (pip)")
fi

if python_package_exists pywayland; then
    echo "✅ pywayland"
else
    echo "❌ pywayland"
    MISSING_CORE+=("python-pywayland")
fi

if python_package_exists setproctitle; then
    echo "✅ setproctitle"
else
    echo "❌ setproctitle"
    MISSING_CORE+=("setproctitle (pip)")
fi

if python_package_exists watchdog; then
    echo "✅ watchdog"
else
    echo "❌ watchdog"
    MISSING_CORE+=("watchdog (pip)")
fi

if python_package_exists loguru; then
    echo "✅ loguru"
else
    echo "❌ loguru"
    MISSING_CORE+=("loguru (pip)")
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ${#MISSING_CORE[@]} -eq 0 ] && [ ${#MISSING_TOOLS[@]} -eq 0 ]; then
    echo "✅ All required dependencies are installed!"
    echo ""
    if [ ${#MISSING_OPTIONAL[@]} -gt 0 ]; then
        echo "Optional packages missing: ${#MISSING_OPTIONAL[@]}"
        echo "Some features may be disabled."
    fi
else
    echo "❌ Missing dependencies detected!"
    echo ""
    
    if [ ${#MISSING_CORE[@]} -gt 0 ]; then
        echo "Missing CORE packages (${#MISSING_CORE[@]}):"
        printf '  - %s\n' "${MISSING_CORE[@]}"
        echo ""
    fi
    
    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        echo "Missing TOOLS packages (${#MISSING_TOOLS[@]}):"
        printf '  - %s\n' "${MISSING_TOOLS[@]}"
        echo ""
    fi
    
    if [ ${#MISSING_OPTIONAL[@]} -gt 0 ]; then
        echo "Missing OPTIONAL packages (${#MISSING_OPTIONAL[@]}):"
        printf '  - %s\n' "${MISSING_OPTIONAL[@]}"
        echo ""
    fi
    
    echo "Install missing packages with:"
    echo "  yay -S ${MISSING_CORE[@]} ${MISSING_TOOLS[@]}"
    echo ""
    echo "Install Python packages with:"
    echo "  pip install --user -r requirements.txt"
fi

echo ""
