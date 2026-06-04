#!/bin/bash
# Blue Team tools — défense, analyse, supervision
echo "[Blue Team] Installation des outils..."

sudo pacman -S --needed --noconfirm \
    wireshark-qt \
    nmap \
    tcpdump \
    netstat-nat \
    net-tools \
    fail2ban \
    clamav \
    rkhunter \
    lynis \
    auditd \
    htop \
    iotop \
    docker \
    docker-compose

# ClamAV — mise à jour des signatures
sudo freshclam 2>/dev/null || true

# Docker
sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# Podman (alternative rootless)
sudo pacman -S --needed --noconfirm podman 2>/dev/null || true

echo "[Blue Team] Installation terminée."
echo "Outils : wireshark, nmap, tcpdump, fail2ban, clamav, rkhunter, lynis, docker, podman"
