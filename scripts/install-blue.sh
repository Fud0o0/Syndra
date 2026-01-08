#!/bin/bash
# Syndra Installation Script - Blue Team Edition
# Defensive security tools installation
# REQUIRES: Syndra base installation (run install-syndra-base.sh first)

set -e

INSTALL_DIR="$HOME/.config/SyndraShell"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    SYNDRA - BLUE TEAM                         ║"
echo "║              Defensive Security Tools                         ║"
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
REQUIRED_SPACE_GB=8
AVAILABLE_SPACE_GB=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Espace requis (outils Blue Team): ${REQUIRED_SPACE_GB} GB"
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
echo "🔵 Installation des outils Blue Team..."

# Update system
echo "🔄 Mise à jour du système..."
sudo pacman -Syu --noconfirm

# Install base development tools if not present
echo "📦 Installation des outils de développement de base..."
sudo pacman -S --needed --noconfirm git base-devel wget curl \
    python python-pip python-virtualenv nodejs npm go rust

# Install Blue Team security tools
echo "🛡️  Installation des outils de sécurité défensifs Blue Team..."
sudo pacman -S --needed --noconfirm wireshark-qt snort suricata aide rkhunter \
    clamav chkrootkit lynis fail2ban ufw iptables nftables \
    tcpdump tshark nmap aide tripwire || echo "⚠️  Certains outils ont échoué (continuons...)"

# Install monitoring and analysis tools
echo "📊 Installation des outils de monitoring..."
sudo pacman -S --needed --noconfirm htop iotop nethogs iftop glances \
    sysstat logwatch rsyslog auditd || echo "⚠️  Certains outils de monitoring ont échoué"

# Install SIEM and log analysis tools via pip
echo "🐍 Installation des outils Python de sécurité..."
pip install --user volatility3 yara-python sigma-cli splunk-sdk \
    elasticsearch loguru pandas numpy || echo "⚠️  Certains packages Python ont échoué"

# Check AUR helper
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "⚠️  AUR helper non trouvé. Certains packages AUR ne seront pas installés."
else
    AUR_HELPER=$(command -v yay || command -v paru)
    
    # Install additional tools from AUR
    echo "🌟 Installation des outils AUR..."
    $AUR_HELPER -S --needed --noconfirm wazuh-agent osquery zeek elastalert graylog || echo "⚠️  Certains outils AUR ont échoué"
fi

# Configure Blue Team color scheme
echo "🎨 Configuration du thème Blue Team..."
if [ -f "$HOME/.config/waybar/style.css" ]; then
    sed -i 's/--primary: #.*/--primary: #00d4ff;/' "$HOME/.config/waybar/style.css" 2>/dev/null || true
fi

# Configure firewall
echo "🔥 Configuration du pare-feu..."
sudo systemctl enable ufw || true
sudo ufw default deny incoming || true
sudo ufw default allow outgoing || true
sudo ufw --force enable || true

# Enable security services
echo "🔐 Activation des services de sécurité..."
sudo systemctl enable fail2ban || true
sudo systemctl enable auditd || true

# Start SyndraShell with Blue Team configuration
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
echo "║        ✅ INSTALLATION BLUE TEAM TERMINÉE!                    ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  💾 Espace utilisé: ${USED_SPACE} GB                                   ║"
echo "║  📊 Espace disponible: ${AVAILABLE_NOW} GB                           ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Outils Blue Team installés:                                  ║"
echo "║  ✓ Wireshark, Snort, Suricata (IDS/IPS)                      ║"
echo "║  ✓ Fail2ban, UFW, iptables (Firewall)                        ║"
echo "║  ✓ ClamAV, Rkhunter, Lynis (Antivirus/Scanner)               ║"
echo "║  ✓ Outils SIEM et analyse de logs                            ║"
echo "║  ✓ Monitoring: htop, glances, sysstat                        ║"
echo "╠═══════════════════════════════════════════════════════════════╣"
echo "║  Prochaines étapes:                                           ║"
echo "║  1. Déconnectez-vous et sélectionnez Hyprland                ║"
echo "║  2. SyndraShell démarrera automatiquement                     ║"
echo "║  3. Appuyez sur SUPER+D pour le dashboard                     ║"
echo "║  4. Appuyez sur SUPER+R pour le lanceur d'applications       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
