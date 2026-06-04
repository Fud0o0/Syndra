#!/bin/bash
# Red Team tools — pentest, audit offensif
echo "[Red Team] Installation des outils..."

sudo pacman -S --needed --noconfirm \
    nmap \
    wireshark-qt \
    tcpdump \
    net-tools \
    netcat \
    hydra \
    john \
    hashcat \
    sqlmap \
    nikto \
    docker \
    docker-compose

sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# Metasploit via Docker (évite les conflits système)
echo "[Red Team] Metasploit via Docker..."
docker pull metasploitframework/metasploit-framework 2>/dev/null || true

# Wordlists
sudo pacman -S --needed --noconfirm wordlists 2>/dev/null || true

echo "[Red Team] Installation terminée."
echo "Outils : nmap, wireshark, hydra, john, hashcat, sqlmap, nikto, metasploit(docker)"
