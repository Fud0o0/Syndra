#!/bin/bash
# Profil personnalisé — base légère + conteneurisation
echo "[Custom] Installation de la base personnalisable..."

sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    podman \
    git \
    curl \
    wget \
    htop \
    neofetch

sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

echo "[Custom] Installation terminée."
echo "Profil de base prêt — ajoute tes outils dans scripts/install/custom.sh"
