# 🎬 Fonds d'Écran Vidéo - Guide Complet

## Vue d'ensemble

Syndra supporte maintenant les **fonds d'écran vidéo** en plus des images statiques ! Utilisez n'importe quelle vidéo MP4, WebM, MKV comme fond d'écran dynamique.

## Formats Supportés

### Vidéos
- **MP4** (H.264, H.265/HEVC)
- **WebM** (VP8, VP9, AV1)
- **MKV** (Matroska)
- **AVI**
- **MOV** (QuickTime)
- **GIF animés**

### Images
- **JPG/JPEG**
- **PNG**
- **WebP**
- **GIF**
- **BMP**

## Installation

### Prérequis

Les fonds d'écran vidéo nécessitent **mpvpaper** :

```bash
yay -S mpvpaper
```

Ou avec paru :
```bash
paru -S mpvpaper
```

### Dépendances Automatiques

L'installation Syndra installe automatiquement :
- `mpvpaper` - Lecteur vidéo pour fond d'écran
- `ffmpeg` - Encodage/décodage vidéo
- `swww` - Fond d'écran statique
- `swaybg` - Fallback pour images

## Utilisation

### Méthode 1 : Script video-wallpaper.sh

#### Définir une Vidéo en Boucle (Sans Son)

```bash
~/. config/SyndraShell/scripts/video-wallpaper.sh video ~/Pictures/Wallpapers/ocean.mp4
```

#### Définir une Vidéo avec Son

```bash
~/.config/SyndraShell/scripts/video-wallpaper.sh video ~/Videos/anime.mp4 --volume 30
```

#### Définir sans Boucle

```bash
~/.config/SyndraShell/scripts/video-wallpaper.sh video ~/Videos/intro.mp4 --loop no
```

#### Définir sur un Moniteur Spécifique

```bash
~/.config/SyndraShell/scripts/video-wallpaper.sh video ~/Videos/bg.mp4 --monitor DP-1
```

#### Lister les Fonds d'Écran Disponibles

```bash
~/.config/SyndraShell/scripts/video-wallpaper.sh list
```

### Méthode 2 : Via Python

```python
from modules.video_wallpaper import VideoWallpaper

manager = VideoWallpaper()

# Définir une vidéo
manager.set_video_wallpaper("~/Pictures/Wallpapers/ocean.mp4", loop=True, volume=0)

# Définir une image
manager.set_static_wallpaper("~/Pictures/Wallpapers/mountain.jpg")

# Auto-détection (vidéo ou image)
manager.set_wallpaper("~/Pictures/Wallpapers/sunset.mp4")

# Lister les fonds d'écran
wallpapers = manager.list_available_wallpapers()
for wp in wallpapers:
    print(f"{wp['type']}: {wp['name']} ({wp['size']} bytes)")
```

### Méthode 3 : Directement avec mpvpaper

```bash
# En boucle, sans son
mpvpaper -o 'loop=inf,no-audio,hwdec=auto' '*' ~/Videos/ocean.mp4

# Avec son, volume 50
mpvpaper -o 'loop=inf,volume=50,hwdec=auto' '*' ~/Videos/anime.mp4

# Sur moniteur spécifique
mpvpaper -o 'loop=inf,no-audio' 'DP-1' ~/Videos/wallpaper.mp4
```

## Configuration Automatique

### Au Démarrage

Pour définir un fond d'écran vidéo au démarrage de Hyprland, ajoutez dans `~/.config/hypr/hyprland.conf` :

```conf
# Fond d'écran vidéo au démarrage
exec-once = mpvpaper -o 'loop=inf,no-audio,hwdec=auto' '*' ~/Pictures/Wallpapers/startup.mp4
```

Ou pour une image :
```conf
# Fond d'écran statique au démarrage
exec-once = swww-daemon --format xrgb
exec = swww img ~/.current.wall --transition-type fade --transition-duration 2
```

### Lien Symbolique .current.wall

Syndra utilise `~/.current.wall` pour suivre le fond d'écran actuel. Le script `video-wallpaper.sh` met automatiquement à jour ce lien.

Pour appliquer le dernier fond d'écran :

```bash
# Si c'est une vidéo
mpvpaper -o 'loop=inf,no-audio,hwdec=auto' '*' "$(readlink ~/.current.wall)"

# Si c'est une image
swww img "$(readlink ~/.current.wall)"
```

## Options Avancées

### Accélération Matérielle

Pour meilleures performances, mpvpaper utilise l'accélération GPU :

```bash
mpvpaper -o 'hwdec=auto,vo=gpu,gpu-context=wayland' '*' video.mp4
```

Options hwdec disponibles :
- `auto` - Détection automatique
- `vaapi` - Intel/AMD
- `nvdec` - NVIDIA
- `vdpau` - NVIDIA (ancien)
- `no` - Désactiver (CPU uniquement)

### Qualité et Performance

#### Haute Qualité (Plus de CPU/GPU)
```bash
mpvpaper -o 'profile=high-quality,vo=gpu,scale=ewa_lanczossharp' '*' video.mp4
```

#### Performance (Moins de ressources)
```bash
mpvpaper -o 'profile=fast,vo=gpu,hwdec=auto' '*' video.mp4
```

#### Économie d'Énergie
```bash
mpvpaper -o 'profile=low-power,fps=30,hwdec=auto' '*' video.mp4
```

### Multi-Moniteurs

#### Même vidéo sur tous les moniteurs
```bash
mpvpaper -o 'loop=inf,no-audio' '*' video.mp4
```

#### Vidéos différentes par moniteur
```bash
# Moniteur principal
mpvpaper -o 'loop=inf,no-audio' 'DP-1' video1.mp4 &

# Moniteur secondaire
mpvpaper -o 'loop=inf,no-audio' 'HDMI-A-1' video2.mp4 &
```

Pour lister vos moniteurs :
```bash
hyprctl monitors
```

## Recommandations

### Résolution et Format

Pour meilleures performances :

- **Résolution** : Même que votre écran (1920x1080, 2560x1440, 3840x2160)
- **FPS** : 30 fps suffisent (économise ressources)
- **Codec** : H.264 (compatibilité), H.265 (meilleure compression), VP9 (WebM)
- **Bitrate** : 5-10 Mbps pour 1080p, 10-20 Mbps pour 4K

### Convertir une Vidéo avec ffmpeg

#### Optimiser pour Fond d'Écran (1080p, 30fps)
```bash
ffmpeg -i input.mp4 -vf "scale=1920:1080" -r 30 -c:v libx264 -preset medium -crf 23 -an output.mp4
```

#### Version Ultra-Compressée (H.265)
```bash
ffmpeg -i input.mp4 -vf "scale=1920:1080" -r 30 -c:v libx265 -preset medium -crf 28 -an output.mp4
```

#### WebM (VP9) - Open Source
```bash
ffmpeg -i input.mp4 -vf "scale=1920:1080" -r 30 -c:v libvpx-vp9 -b:v 2M -an output.webm
```

#### Créer une Boucle Parfaite
```bash
ffmpeg -stream_loop -1 -i input.mp4 -t 300 -vf "scale=1920:1080" -r 30 -c:v libx264 -an output.mp4
```

### Taille de Fichier

Pour garder un fichier léger :

- **30 secondes** : ~10-20 MB
- **1 minute** : ~20-40 MB
- **5 minutes** : ~100-200 MB

💡 **Astuce** : Une courte vidéo en boucle (15-30s) est souvent suffisante et économise disque/RAM.

## Sources de Vidéos

### Sites Gratuits

- [Pexels Videos](https://www.pexels.com/videos/) - Vidéos gratuites HD/4K
- [Pixabay Videos](https://pixabay.com/videos/) - Vidéos libres de droits
- [Coverr](https://coverr.co/) - Vidéos pour fond d'écran
- [Videvo](https://www.videvo.net/) - Stock vidéo gratuit
- [Mixkit](https://mixkit.co/free-stock-video/) - Vidéos HD gratuites

### Thèmes Populaires

- **Nature** : Océan, forêt, montagne, ciel étoilé
- **Abstrait** : Particules, formes géométriques, fractales
- **Cyberpunk** : Néons, ville futuriste, pluie
- **Minimaliste** : Formes simples, couleurs unies animées
- **Espace** : Galaxies, nébuleuses, planètes

## Performance

### Utilisation Ressources

Une vidéo 1080p@30fps en boucle utilise typiquement :

- **CPU** : 5-15% (avec hwdec)
- **GPU** : 10-20%
- **RAM** : 50-150 MB
- **VRAM** : 100-300 MB

### Optimisation

Si vous rencontrez des ralentissements :

1. **Réduire la résolution** : 1080p → 720p
2. **Réduire FPS** : 60fps → 30fps
3. **Activer hwdec** : `hwdec=auto`
4. **Utiliser H.264** au lieu de H.265 (moins CPU)
5. **Réduire durée** : Utiliser vidéo plus courte en boucle

## Dépannage

### mpvpaper ne démarre pas

```bash
# Vérifier si installé
which mpvpaper

# Tester manuellement
mpvpaper -o 'loop=inf,no-audio' '*' ~/Pictures/Wallpapers/test.mp4

# Voir les logs
mpvpaper -o 'loop=inf,no-audio' '*' ~/Pictures/Wallpapers/test.mp4 --verbose
```

### Vidéo ne s'affiche pas

1. Vérifier que Wayland est actif : `echo $WAYLAND_DISPLAY`
2. Tester avec une vidéo simple
3. Vérifier les codecs : `ffprobe video.mp4`
4. Essayer sans hwdec : `mpvpaper -o 'hwdec=no' '*' video.mp4`

### Mauvaise Performance

```bash
# Vérifier CPU/GPU
htop

# Profil rapide
mpvpaper -o 'profile=fast,fps=24,hwdec=auto' '*' video.mp4

# Réduire qualité
mpvpaper -o 'vd-lavc-threads=2,hwdec=auto' '*' video.mp4
```

### Arrêter le Fond d'Écran

```bash
# Arrêter mpvpaper
killall mpvpaper

# Ou utiliser le script
~/.config/SyndraShell/scripts/video-wallpaper.sh stop
```

## Exemples de Configuration

### Setup Gaming

```bash
# Vidéo légère, max performance
mpvpaper -o 'loop=inf,no-audio,fps=24,hwdec=auto,profile=fast' '*' ~/Videos/minimal.mp4
```

### Setup Productivité

```bash
# Vidéo calme, océan ou forêt
mpvpaper -o 'loop=inf,no-audio,fps=30' '*' ~/Videos/forest-4k.mp4
```

### Setup Streaming

```bash
# Vidéo cyberpunk avec volume faible
mpvpaper -o 'loop=inf,volume=20,fps=60,hwdec=auto' '*' ~/Videos/cyberpunk.mp4
```

### Setup Minimal

```bash
# Image statique (0% CPU après chargement)
swww img ~/Pictures/Wallpapers/minimal.png
```

## Scripts Utiles

### Fond d'Écran Aléatoire au Démarrage

Créez `~/.config/hypr/scripts/random-wallpaper.sh` :

```bash
#!/bin/bash
WALLPAPERS=~/Pictures/Wallpapers
RANDOM_WALL=$(find "$WALLPAPERS" -type f \( -name "*.mp4" -o -name "*.jpg" -o -name "*.png" \) | shuf -n 1)

if [[ "$RANDOM_WALL" =~ \.mp4$ ]]; then
    mpvpaper -o 'loop=inf,no-audio,hwdec=auto' '*' "$RANDOM_WALL"
else
    swww img "$RANDOM_WALL" --transition-type fade
fi
```

Puis dans `hyprland.conf` :
```conf
exec-once = ~/.config/hypr/scripts/random-wallpaper.sh
```

### Changer Fond d'Écran par Heure

```bash
#!/bin/bash
HOUR=$(date +%H)

if [ $HOUR -ge 6 ] && [ $HOUR -lt 12 ]; then
    # Matin
    VIDEO="~/Videos/sunrise.mp4"
elif [ $HOUR -ge 12 ] && [ $HOUR -lt 18 ]; then
    # Après-midi
    VIDEO="~/Videos/day.mp4"
elif [ $HOUR -ge 18 ] && [ $HOUR -lt 22 ]; then
    # Soirée
    VIDEO="~/Videos/sunset.mp4"
else
    # Nuit
    VIDEO="~/Videos/night.mp4"
fi

mpvpaper -o 'loop=inf,no-audio,hwdec=auto' '*' "$VIDEO"
```

---

**🎬 Profitez de vos fonds d'écran vidéo dynamiques avec Syndra !**

**🔗 Liens Utiles:**
- [mpvpaper GitHub](https://github.com/GhostNaN/mpvpaper)
- [mpv Manual](https://mpv.io/manual/stable/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
