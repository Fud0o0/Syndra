#!/bin/bash
# Root-Me / CTF tools — reverse, pwn, crypto, forensics, web
echo "[Root-Me] Installation des outils CTF..."

sudo pacman -S --needed --noconfirm \
    nmap \
    netcat \
    gdb \
    radare2 \
    binwalk \
    foremost \
    sqlmap \
    john \
    hashcat \
    python python-pip \
    docker docker-compose

sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# Outils Python CTF
pip install --break-system-packages pwntools requests 2>/dev/null || \
pip install --user pwntools requests 2>/dev/null || true

# Images Docker CTF
echo "[Root-Me] Préparation des conteneurs CTF..."
docker pull kalilinux/kali-rolling 2>/dev/null || true

echo "[Root-Me] Installation terminée."
echo "Outils : nmap, gdb, radare2, binwalk, sqlmap, john, hashcat, pwntools, kali(docker)"
