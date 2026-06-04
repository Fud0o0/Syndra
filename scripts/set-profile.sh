#!/bin/bash
# Syndra profile switcher — changes color theme + installs profile tools
# Usage: set-profile.sh [blue-team|red-team|purple|green|mono|default]

PROFILE="${1:-default}"
CONFIG_FILE="$HOME/.config/SyndraShell/config/config.json"
INSTALL_DIR="$HOME/.config/SyndraShell"

VALID=("blue-team" "red-team" "purple" "green" "mono" "default")
VALID_STR=$(IFS="|"; echo "${VALID[*]}")

if [[ ! " ${VALID[*]} " =~ " ${PROFILE} " ]]; then
    echo "Usage: $0 [${VALID_STR}]"
    exit 1
fi

echo "[Syndra] Switching to profile: $PROFILE"

# Update config.json
if command -v python &>/dev/null; then
    python - <<PYEOF
import json, os
cfg = "$CONFIG_FILE"
data = {}
if os.path.exists(cfg):
    with open(cfg) as f:
        try: data = json.load(f)
        except: pass
data["syndra_profile"] = "$PROFILE"
with open(cfg, "w") as f:
    json.dump(data, f, indent=2)
print("[Syndra] Profile saved to config.json")
PYEOF
fi

# Offer to install profile tools
if [ -f "$INSTALL_DIR/scripts/install/${PROFILE}.sh" ]; then
    echo "[Syndra] Install tools for $PROFILE? [y/N]"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        bash "$INSTALL_DIR/scripts/install/${PROFILE}.sh"
    fi
fi

# Restart SyndraShell to apply new theme
echo "[Syndra] Restarting SyndraShell..."
pkill -f "python.*main.py" 2>/dev/null
sleep 0.5
cd "$INSTALL_DIR" && python main.py &
echo "[Syndra] Done. Profile: $PROFILE"
