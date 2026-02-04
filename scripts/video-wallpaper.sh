#!/bin/bash
# Syndra Video Wallpaper Manager
# Gère les fonds d'écran vidéo avec mpvpaper

set -e

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
CURRENT_WALLPAPER="$HOME/.current.wall"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Fonctions utilitaires
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Vérifier si mpvpaper est installé
check_mpvpaper() {
    if ! command -v mpvpaper &> /dev/null; then
        print_error "mpvpaper n'est pas installé"
        echo ""
        echo "Installez-le avec:"
        echo "  yay -S mpvpaper"
        echo ""
        exit 1
    fi
}

# Vérifier si un fichier est une vidéo
is_video() {
    local file="$1"
    case "${file,,}" in
        *.mp4|*.webm|*.mkv|*.avi|*.mov|*.gif)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Arrêter tous les fonds d'écran
stop_wallpapers() {
    print_info "Arrêt des fonds d'écran actuels..."
    killall mpvpaper 2>/dev/null || true
    killall swww 2>/dev/null || true
    killall swaybg 2>/dev/null || true
    sleep 0.5
}

# Définir un fond d'écran vidéo
set_video_wallpaper() {
    local video_path="$1"
    local loop="${2:-yes}"
    local volume="${3:-0}"
    local monitor="${4:-*}"
    
    if [ ! -f "$video_path" ]; then
        print_error "Fichier introuvable: $video_path"
        exit 1
    fi
    
    if ! is_video "$video_path"; then
        print_error "Le fichier n'est pas une vidéo supportée"
        exit 1
    fi
    
    check_mpvpaper
    stop_wallpapers
    
    print_info "Définition du fond d'écran vidéo..."
    
    # Options mpvpaper
    local loop_option="no"
    if [ "$loop" = "yes" ] || [ "$loop" = "true" ] || [ "$loop" = "1" ]; then
        loop_option="inf"
    fi
    
    local mpv_options="loop=${loop_option},volume=${volume}"
    
    if [ "$volume" = "0" ]; then
        mpv_options="${mpv_options},no-audio"
    fi
    
    # Ajouter accélération matérielle
    mpv_options="${mpv_options},hwdec=auto,vo=gpu,gpu-context=wayland"
    
    # Lancer mpvpaper
    mpvpaper -o "$mpv_options" "$monitor" "$video_path" >/dev/null 2>&1 &
    
    # Mettre à jour le lien symbolique
    rm -f "$CURRENT_WALLPAPER"
    ln -s "$video_path" "$CURRENT_WALLPAPER"
    
    sleep 1
    print_success "Fond d'écran vidéo défini: $(basename "$video_path")"
}

# Définir un fond d'écran image
set_image_wallpaper() {
    local image_path="$1"
    
    if [ ! -f "$image_path" ]; then
        print_error "Fichier introuvable: $image_path"
        exit 1
    fi
    
    stop_wallpapers
    
    print_info "Définition du fond d'écran image..."
    
    # Essayer swww
    if command -v swww &> /dev/null; then
        swww-daemon --format xrgb >/dev/null 2>&1 || true
        sleep 1
        swww img "$image_path" --transition-type fade --transition-duration 2
        print_success "Fond d'écran défini avec swww"
    # Fallback swaybg
    elif command -v swaybg &> /dev/null; then
        swaybg -i "$image_path" -m fill >/dev/null 2>&1 &
        print_success "Fond d'écran défini avec swaybg"
    else
        print_error "Aucun gestionnaire de fond d'écran disponible (swww/swaybg)"
        exit 1
    fi
    
    # Mettre à jour le lien symbolique
    rm -f "$CURRENT_WALLPAPER"
    ln -s "$image_path" "$CURRENT_WALLPAPER"
}

# Lister les fonds d'écran disponibles
list_wallpapers() {
    if [ ! -d "$WALLPAPERS_DIR" ]; then
        print_warning "Répertoire de fonds d'écran introuvable: $WALLPAPERS_DIR"
        exit 1
    fi
    
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "  FONDS D'ÉCRAN DISPONIBLES"
    echo "═══════════════════════════════════════════════════════"
    echo ""
    
    local count=0
    local video_count=0
    local image_count=0
    
    for file in "$WALLPAPERS_DIR"/*; do
        if [ -f "$file" ]; then
            local basename=$(basename "$file")
            local size=$(du -h "$file" | cut -f1)
            
            if is_video "$file"; then
                echo -e "  ${CYAN}🎬${NC} $basename ($size)"
                ((video_count++))
            else
                echo -e "  ${GREEN}🖼️${NC}  $basename ($size)"
                ((image_count++))
            fi
            ((count++))
        fi
    done
    
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "  Total: $count ($image_count images, $video_count vidéos)"
    echo "═══════════════════════════════════════════════════════"
    echo ""
}

# Afficher l'aide
show_help() {
    cat << EOF
╔═══════════════════════════════════════════════════════════╗
║        SYNDRA VIDEO WALLPAPER MANAGER                     ║
╚═══════════════════════════════════════════════════════════╝

USAGE:
  $(basename "$0") [COMMAND] [OPTIONS]

COMMANDS:
  set <file>          Définir un fond d'écran (image ou vidéo)
  video <file>        Définir un fond d'écran vidéo
  image <file>        Définir un fond d'écran image
  list                Lister les fonds d'écran disponibles
  stop                Arrêter tous les fonds d'écran
  help                Afficher cette aide

OPTIONS (pour vidéo):
  --loop yes|no       Lire en boucle (défaut: yes)
  --volume 0-100      Volume audio (défaut: 0)
  --monitor <name>    Moniteur cible (défaut: *)

EXEMPLES:
  # Définir une vidéo en boucle sans son
  $(basename "$0") video ~/Pictures/Wallpapers/ocean.mp4

  # Définir une vidéo avec son
  $(basename "$0") video ~/Videos/anime.mp4 --volume 30

  # Définir une image
  $(basename "$0") image ~/Pictures/Wallpapers/mountain.jpg

  # Lister les fonds d'écran
  $(basename "$0") list

RÉPERTOIRE:
  Les fonds d'écran doivent être dans: $WALLPAPERS_DIR

FORMATS SUPPORTÉS:
  Images: JPG, PNG, WebP, GIF
  Vidéos: MP4, WebM, MKV, AVI, MOV

EOF
}

# Parse arguments
COMMAND="${1:-help}"
shift || true

case "$COMMAND" in
    set)
        if [ -z "$1" ]; then
            print_error "Aucun fichier spécifié"
            echo "Usage: $(basename "$0") set <file>"
            exit 1
        fi
        
        if is_video "$1"; then
            set_video_wallpaper "$@"
        else
            set_image_wallpaper "$1"
        fi
        ;;
    
    video)
        if [ -z "$1" ]; then
            print_error "Aucun fichier vidéo spécifié"
            echo "Usage: $(basename "$0") video <file> [--loop yes|no] [--volume 0-100] [--monitor <name>]"
            exit 1
        fi
        
        video_file="$1"
        shift
        
        loop="yes"
        volume="0"
        monitor="*"
        
        while [ $# -gt 0 ]; do
            case "$1" in
                --loop)
                    loop="$2"
                    shift 2
                    ;;
                --volume)
                    volume="$2"
                    shift 2
                    ;;
                --monitor)
                    monitor="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done
        
        set_video_wallpaper "$video_file" "$loop" "$volume" "$monitor"
        ;;
    
    image)
        if [ -z "$1" ]; then
            print_error "Aucun fichier image spécifié"
            echo "Usage: $(basename "$0") image <file>"
            exit 1
        fi
        set_image_wallpaper "$1"
        ;;
    
    list)
        list_wallpapers
        ;;
    
    stop)
        stop_wallpapers
        print_success "Tous les fonds d'écran ont été arrêtés"
        ;;
    
    help|--help|-h)
        show_help
        ;;
    
    *)
        print_error "Commande inconnue: $COMMAND"
        echo ""
        show_help
        exit 1
        ;;
esac
