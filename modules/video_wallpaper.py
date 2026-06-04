#!/usr/bin/env python3
"""
Module de Gestion des Fonds d'Écran Vidéo
Supporte MP4, WebM, MKV via mpvpaper
"""

import os
import subprocess
from pathlib import Path

class VideoWallpaper:
    """Gère les fonds d'écran vidéo avec mpvpaper"""
    
    SUPPORTED_FORMATS = [".mp4", ".webm", ".mkv", ".avi", ".mov", ".gif"]
    
    def __init__(self):
        self.current_video = None
        self.mpvpaper_running = False
    
    def is_video_file(self, file_path):
        """Vérifie si le fichier est une vidéo supportée"""
        if not os.path.exists(file_path):
            return False
        
        ext = Path(file_path).suffix.lower()
        return ext in self.SUPPORTED_FORMATS
    
    def check_mpvpaper_installed(self):
        """Vérifie si mpvpaper est installé"""
        try:
            result = subprocess.run(
                ["which", "mpvpaper"],
                capture_output=True,
                text=True
            )
            return result.returncode == 0
        except Exception:
            return False
    
    def stop_current_wallpaper(self):
        """Arrête le fond d'écran vidéo actuel"""
        try:
            subprocess.run(["killall", "mpvpaper"], stderr=subprocess.DEVNULL)
            subprocess.run(["killall", "awww"], stderr=subprocess.DEVNULL)
            subprocess.run(["killall", "swaybg"], stderr=subprocess.DEVNULL)
            self.mpvpaper_running = False
        except Exception as e:
            print(f"Erreur lors de l'arrêt du fond d'écran: {e}")
    
    def set_video_wallpaper(self, video_path, loop=True, volume=0, monitor="*"):
        """
        Définit une vidéo comme fond d'écran
        
        Args:
            video_path: Chemin vers le fichier vidéo
            loop: Lire en boucle (défaut: True)
            volume: Volume audio (0-100, défaut: 0 pour muet)
            monitor: Moniteur cible ("*" pour tous, "DP-1", etc.)
        
        Returns:
            bool: True si succès, False sinon
        """
        if not self.is_video_file(video_path):
            print(f"❌ {video_path} n'est pas un fichier vidéo supporté")
            return False
        
        if not self.check_mpvpaper_installed():
            print("❌ mpvpaper n'est pas installé")
            print("   Installez-le avec: yay -S mpvpaper")
            return False
        
        # Arrêter le fond d'écran actuel
        self.stop_current_wallpaper()
        
        # Construire les options mpvpaper
        mpv_options = [
            f"loop={'inf' if loop else 'no'}",
            f"volume={volume}",
            "no-audio" if volume == 0 else "",
            "hwdec=auto",  # Accélération matérielle
            "vo=gpu",
            "gpu-context=wayland",
        ]
        
        # Filtrer les options vides
        mpv_options = [opt for opt in mpv_options if opt]
        options_str = ",".join(mpv_options)
        
        try:
            # Lancer mpvpaper
            cmd = [
                "mpvpaper",
                "-o", options_str,
                monitor,
                video_path
            ]
            
            # Lancer en arrière-plan
            subprocess.Popen(
                cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True
            )
            
            self.current_video = video_path
            self.mpvpaper_running = True
            print(f"✓ Fond d'écran vidéo défini: {os.path.basename(video_path)}")
            return True
            
        except Exception as e:
            print(f"❌ Erreur lors du lancement de mpvpaper: {e}")
            return False
    
    def set_static_wallpaper(self, image_path):
        """
        Définit une image statique comme fond d'écran
        Utilise awww ou swaybg selon disponibilité
        """
        if not os.path.exists(image_path):
            print(f"❌ {image_path} n'existe pas")
            return False
        
        # Arrêter les fonds d'écran vidéo
        self.stop_current_wallpaper()
        
        try:
            # Essayer swww d'abord
            if subprocess.run(["which", "awww"], capture_output=True).returncode == 0:
                # Démarrer swww daemon
                subprocess.Popen(
                    ["awww init", "--format", "xrgb"],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL
                )
                
                # Attendre un peu puis appliquer l'image
                import time
                time.sleep(1)
                
                subprocess.run([
                    "awww", "img", image_path,
                    "--transition-type", "fade",
                    "--transition-duration", "2"
                ])
                print(f"✓ Fond d'écran défini (awww): {os.path.basename(image_path)}")
                return True
            
            # Fallback sur swaybg
            elif subprocess.run(["which", "swaybg"], capture_output=True).returncode == 0:
                subprocess.Popen(
                    ["swaybg", "-i", image_path, "-m", "fill"],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                    start_new_session=True
                )
                print(f"✓ Fond d'écran défini (swaybg): {os.path.basename(image_path)}")
                return True
            
            else:
                print("❌ Aucun gestionnaire de fond d'écran disponible (awww/swaybg)")
                return False
                
        except Exception as e:
            print(f"❌ Erreur lors de la définition du fond d'écran: {e}")
            return False
    
    def set_wallpaper(self, file_path, **kwargs):
        """
        Définit un fond d'écran (détecte automatiquement image/vidéo)
        
        Args:
            file_path: Chemin vers le fichier
            **kwargs: Options supplémentaires pour vidéo (loop, volume, monitor)
        """
        if self.is_video_file(file_path):
            return self.set_video_wallpaper(file_path, **kwargs)
        else:
            return self.set_static_wallpaper(file_path)
    
    def get_wallpapers_directory(self):
        """Retourne le répertoire des fonds d'écran"""
        wallpapers_dir = os.path.expanduser("~/Pictures/Wallpapers")
        os.makedirs(wallpapers_dir, exist_ok=True)
        return wallpapers_dir
    
    def list_available_wallpapers(self, include_videos=True):
        """Liste tous les fonds d'écran disponibles"""
        wallpapers_dir = self.get_wallpapers_directory()
        
        image_extensions = [".jpg", ".jpeg", ".png", ".webp", ".gif"]
        all_extensions = image_extensions + self.SUPPORTED_FORMATS if include_videos else image_extensions
        
        wallpapers = []
        
        try:
            for file in os.listdir(wallpapers_dir):
                file_path = os.path.join(wallpapers_dir, file)
                if Path(file).suffix.lower() in all_extensions:
                    wallpapers.append({
                        "name": file,
                        "path": file_path,
                        "type": "video" if self.is_video_file(file_path) else "image",
                        "size": os.path.getsize(file_path)
                    })
        except Exception as e:
            print(f"Erreur lors du listage des fonds d'écran: {e}")
        
        return wallpapers

def main():
    """Test du module"""
    print("🎬 Module de Gestion des Fonds d'Écran Vidéo")
    print("=" * 50)
    
    manager = VideoWallpaper()
    
    # Vérifier mpvpaper
    if manager.check_mpvpaper_installed():
        print("✓ mpvpaper est installé")
    else:
        print("❌ mpvpaper n'est pas installé")
        print("   Installez-le avec: yay -S mpvpaper")
    
    # Lister les fonds d'écran
    wallpapers = manager.list_available_wallpapers()
    print(f"\n📁 {len(wallpapers)} fonds d'écran trouvés:")
    
    for wp in wallpapers:
        size_mb = wp["size"] / (1024 * 1024)
        icon = "🎬" if wp["type"] == "video" else "🖼️"
        print(f"  {icon} {wp['name']} ({size_mb:.2f} MB)")

if __name__ == "__main__":
    main()
