#!/usr/bin/env python3
"""
Script de test rapide pour l'interface provisoire
Vérifie les dépendances et lance l'interface
"""

import sys
import os

def check_dependencies():
    """Vérifie que toutes les dépendances sont présentes"""
    print("🔍 Vérification des dépendances...")
    
    # Vérifier Python GTK
    try:
        import gi
        gi.require_version('Gtk', '3.0')
        from gi.repository import Gtk
        print("  ✓ GTK3 disponible")
    except Exception as e:
        print(f"  ❌ GTK3 non disponible: {e}")
        print("\n  Installation requise:")
        print("  sudo pacman -S python-gobject gtk3")
        return False
    
    # Vérifier le fichier de l'interface
    interface_path = os.path.join(
        os.path.dirname(__file__),
        "provisional_interface.py"
    )
    
    if os.path.exists(interface_path):
        print(f"  ✓ Interface trouvée: {interface_path}")
    else:
        print(f"  ❌ Interface non trouvée: {interface_path}")
        return False
    
    return True

def main():
    """Point d'entrée principal"""
    print("╔═══════════════════════════════════════════════════════════════╗")
    print("║         SYNDRA - Test de l'Interface Provisoire              ║")
    print("╚═══════════════════════════════════════════════════════════════╝")
    print()
    
    if not check_dependencies():
        print("\n❌ Des dépendances sont manquantes. Installation impossible.")
        sys.exit(1)
    
    print("\n✅ Toutes les dépendances sont présentes")
    print("🚀 Lancement de l'interface...\n")
    
    # Lancer l'interface
    interface_path = os.path.join(
        os.path.dirname(__file__),
        "provisional_interface.py"
    )
    
    os.system(f"python '{interface_path}'")

if __name__ == "__main__":
    main()
