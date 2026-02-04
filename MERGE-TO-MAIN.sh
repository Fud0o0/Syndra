#!/bin/bash
# Script pour merger la branche update vers main

echo "🔄 Merge de la branche 'update' vers 'main'"
echo "==========================================="
echo ""

# Vérifier qu'on est sur update
CURRENT=$(git branch --show-current)
if [ "$CURRENT" != "update" ]; then
    echo "❌ Tu n'es pas sur la branche 'update'"
    echo "   Branche actuelle: $CURRENT"
    exit 1
fi

echo "✅ Sur la branche update"
echo ""

# Commit les changements en cours
echo "📦 Commit des modifications..."
git add .
git commit -m "🎨 Ajout interface Iceland + thèmes + wallpapers vidéo + corrections" || echo "Aucune modification à commiter"
echo ""

# Push update
echo "⬆️  Push de la branche update..."
git push origin update
echo ""

# Switch vers main
echo "🔀 Passage sur la branche main..."
git checkout main
echo ""

# Pull main
echo "⬇️  Pull de main..."
git pull origin main
echo ""

# Merge update dans main
echo "🔗 Merge de update dans main..."
git merge update -m "Merge update: Interface Iceland, 6 thèmes dynamiques, wallpapers vidéo MP4, corrections GTK"
echo ""

# Push main
echo "⬆️  Push de main..."
git push origin main
echo ""

# Retour sur update
echo "🔀 Retour sur la branche update..."
git checkout update
echo ""

echo "✅ TERMINÉ !"
echo "==========================================="
echo "Maintenant sur ton Linux, tu peux faire:"
echo "  syndra update"
echo ""
echo "Et tu auras:"
echo "  ✅ Interface Iceland avec boutons ✕"
echo "  ✅ 6 thèmes dynamiques"
echo "  ✅ Wallpapers vidéo MP4"
echo "  ✅ Corrections des erreurs GTK"
echo "  ✅ Configuration Hyprland corrigée"
echo ""
