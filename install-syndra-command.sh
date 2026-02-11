#!/bin/bash
# Installation rapide de la commande syndra

INSTALL_DIR="$HOME/.config/SyndraShell"

if [ ! -f "$INSTALL_DIR/syndra" ]; then
    echo "❌ Le fichier syndra n'existe pas dans $INSTALL_DIR"
    exit 1
fi

# Rendre le script exécutable
chmod +x "$INSTALL_DIR/syndra"

# Créer le répertoire .local/bin si nécessaire
mkdir -p "$HOME/.local/bin"

# Créer le lien symbolique
ln -sf "$INSTALL_DIR/syndra" "$HOME/.local/bin/syndra"

# Vérifier si .local/bin est dans le PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  $HOME/.local/bin n'est pas dans votre PATH"
    echo ""
    echo "Ajoutez cette ligne à votre ~/.bashrc ou ~/.zshrc :"
    echo ""
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Puis rechargez votre shell avec: source ~/.bashrc"
    echo ""
else
    echo "✅ Commande syndra installée avec succès!"
    echo ""
    echo "Vous pouvez maintenant utiliser:"
    echo "  syndra update      - Mettre à jour"
    echo "  syndra restart     - Redémarrer"
    echo "  syndra provisional - Interface de test"
    echo "  syndra help        - Aide"
    echo ""
fi
