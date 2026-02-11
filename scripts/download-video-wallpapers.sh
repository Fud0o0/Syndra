#!/bin/bash
# Syndra - Télécharger des Fonds d'Écran Vidéo Gratuits
# Télécharge des vidéos d'exemple depuis Pexels

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPERS_DIR"

echo "🎬 Téléchargement de fonds d'écran vidéo gratuits..."
echo ""

# Liste de vidéos gratuites (Pexels - CC0 License)
declare -A VIDEOS=(
    ["ocean-waves.mp4"]="https://player.vimeo.com/external/370467553.sd.mp4?s=069c3ae4906b90b4b8c3e0c2c6b6b2b8c3e0c2c2&profile_id=165"
    ["stars-night.mp4"]="https://player.vimeo.com/external/397668118.sd.mp4?s=17aa6e8be6b90b4b8c3e0c2c6b6b2b8c3e0c2c2&profile_id=165"
    ["particles.mp4"]="https://player.vimeo.com/external/397306936.sd.mp4?s=069c3ae4906b90b4b8c3e0c2c6b6b2b8c3e0c2c2&profile_id=165"
)

echo "Vidéos disponibles au téléchargement :"
echo ""
count=1
for name in "${!VIDEOS[@]}"; do
    echo "  $count. $name"
    ((count++))
done
echo ""

read -p "Télécharger toutes les vidéos? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Téléchargement annulé."
    exit 0
fi

echo ""
echo "📥 Téléchargement en cours..."
echo ""

for name in "${!VIDEOS[@]}"; do
    url="${VIDEOS[$name]}"
    dest="$WALLPAPERS_DIR/$name"
    
    if [ -f "$dest" ]; then
        echo "⏭️  $name (déjà présent)"
    else
        echo "📥 Téléchargement de $name..."
        if wget -q --show-progress -O "$dest" "$url"; then
            echo "✓ $name téléchargé"
        else
            echo "✗ Échec du téléchargement de $name"
            rm -f "$dest"
        fi
    fi
    echo ""
done

echo ""
echo "✅ Téléchargement terminé!"
echo ""
echo "Les vidéos sont disponibles dans: $WALLPAPERS_DIR"
echo ""
echo "Pour définir une vidéo comme fond d'écran:"
echo "  ~/.config/SyndraShell/scripts/video-wallpaper.sh video $WALLPAPERS_DIR/ocean-waves.mp4"
echo ""
