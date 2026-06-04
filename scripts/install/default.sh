#!/bin/bash
# Default tools — usage général + conteneurisation
echo "[Default] Installation des outils de base..."

sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    podman \
    git \
    curl \
    wget \
    htop \
    neofetch \
    bat \
    fd \
    ripgrep

sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

echo "[Default] Installation terminée."
