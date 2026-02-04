#!/usr/bin/env python3
"""
Test des Thèmes Syndra
Vérification rapide de tous les thèmes
"""

import sys
import os

# Ajouter le chemin du projet
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    from config.themes import THEMES, get_theme_css, list_themes
    print("✓ Module themes importé avec succès")
except ImportError as e:
    print(f"✗ Erreur d'import: {e}")
    sys.exit(1)

def test_themes_structure():
    """Teste la structure des thèmes"""
    print("\n🔍 Test de la structure des thèmes...")
    
    required_keys = ["name", "description", "icon", "colors"]
    required_colors = ["primary", "secondary", "accent", "background", 
                      "surface", "text", "text_secondary", "border", 
                      "shadow", "gradient_start", "gradient_end"]
    
    errors = []
    
    for theme_id, theme in THEMES.items():
        # Vérifier les clés principales
        for key in required_keys:
            if key not in theme:
                errors.append(f"Thème '{theme_id}': clé manquante '{key}'")
        
        # Vérifier les couleurs
        if "colors" in theme:
            for color_key in required_colors:
                if color_key not in theme["colors"]:
                    errors.append(f"Thème '{theme_id}': couleur manquante '{color_key}'")
    
    if errors:
        print("✗ Erreurs détectées:")
        for error in errors:
            print(f"  - {error}")
        return False
    else:
        print(f"✓ Tous les {len(THEMES)} thèmes sont correctement structurés")
        return True

def test_css_generation():
    """Teste la génération de CSS"""
    print("\n🎨 Test de la génération CSS...")
    
    errors = []
    
    for theme_id in THEMES.keys():
        try:
            css = get_theme_css(theme_id)
            if not css or len(css) < 100:
                errors.append(f"CSS vide ou trop court pour '{theme_id}'")
            
            # Vérifier que le CSS contient des éléments clés
            required_elements = ["window", "button", "header"]
            for element in required_elements:
                if element not in css:
                    errors.append(f"Élément '{element}' manquant dans CSS de '{theme_id}'")
        
        except Exception as e:
            errors.append(f"Erreur de génération CSS pour '{theme_id}': {e}")
    
    if errors:
        print("✗ Erreurs détectées:")
        for error in errors:
            print(f"  - {error}")
        return False
    else:
        print(f"✓ CSS généré avec succès pour tous les thèmes")
        return True

def test_list_themes():
    """Teste la fonction list_themes"""
    print("\n📋 Test de list_themes()...")
    
    try:
        themes = list_themes()
        if len(themes) != len(THEMES):
            print(f"✗ Nombre de thèmes incorrect: {len(themes)} vs {len(THEMES)}")
            return False
        
        for theme_id, info in themes.items():
            required = ["name", "icon", "description"]
            for key in required:
                if key not in info:
                    print(f"✗ Clé '{key}' manquante pour '{theme_id}'")
                    return False
        
        print(f"✓ list_themes() retourne {len(themes)} thèmes valides")
        return True
    
    except Exception as e:
        print(f"✗ Erreur: {e}")
        return False

def display_themes():
    """Affiche tous les thèmes disponibles"""
    print("\n" + "="*60)
    print("🎨 THÈMES SYNDRA DISPONIBLES")
    print("="*60)
    
    for theme_id, theme in THEMES.items():
        print(f"\n{theme['icon']} {theme['name']}")
        print(f"   ID: {theme_id}")
        print(f"   Description: {theme['description']}")
        print(f"   Couleurs:")
        colors = theme['colors']
        print(f"     - Primary: {colors['primary']}")
        print(f"     - Secondary: {colors['secondary']}")
        print(f"     - Accent: {colors['accent']}")

def main():
    """Fonction principale"""
    print("╔═══════════════════════════════════════════════════════╗")
    print("║       SYNDRA THEMES - TEST DE VALIDATION             ║")
    print("╚═══════════════════════════════════════════════════════╝")
    
    results = []
    
    # Exécuter les tests
    results.append(("Structure", test_themes_structure()))
    results.append(("Génération CSS", test_css_generation()))
    results.append(("list_themes()", test_list_themes()))
    
    # Afficher les thèmes
    display_themes()
    
    # Résumé
    print("\n" + "="*60)
    print("📊 RÉSUMÉ DES TESTS")
    print("="*60)
    
    for test_name, passed in results:
        status = "✓ PASS" if passed else "✗ FAIL"
        print(f"{status} - {test_name}")
    
    all_passed = all(result[1] for result in results)
    
    if all_passed:
        print("\n✅ Tous les tests sont passés!")
        print(f"🎉 {len(THEMES)} thèmes prêts à l'emploi")
        return 0
    else:
        print("\n❌ Certains tests ont échoué")
        return 1

if __name__ == "__main__":
    sys.exit(main())
