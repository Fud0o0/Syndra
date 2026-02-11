# 🎨 Syndra Themes - Documentation

## Vue d'ensemble

Syndra dispose maintenant d'un système de thèmes dynamiques permettant de personnaliser l'apparence de toutes les interfaces en temps réel.

## Thèmes Disponibles

### ❄️ Iceland (Glacier)
**Style:** Tons bleus froids, inspiré des paysages islandais
- **Couleurs primaires:** Bleu glacier (#0288d1, #0277bd)
- **Ambiance:** Fraîche, professionnelle, apaisante
- **Usage recommandé:** Travail de longue durée, environnements lumineux

### 🌃 Tokyo Night
**Style:** Thème sombre inspiré de Tokyo la nuit
- **Couleurs primaires:** Bleu-violet (#7aa2f7, #bb9af7)
- **Ambiance:** Moderne, cyberpunk, nocturne
- **Usage recommandé:** Travail de nuit, faible luminosité

### 🌅 Sunset
**Style:** Tons chauds orangés et rouges
- **Couleurs primaires:** Orange (#ff6f00, #f57c00)
- **Ambiance:** Chaleureuse, énergique, dynamique
- **Usage recommandé:** Sessions créatives, brainstorming

### 🌲 Forest
**Style:** Tons naturels verts
- **Couleurs primaires:** Vert forêt (#2e7d32, #388e3c)
- **Ambiance:** Naturelle, reposante, équilibrée
- **Usage recommandé:** Réduction de la fatigue visuelle

### 🔮 Purple Haze
**Style:** Mystique avec tons violets
- **Couleurs primaires:** Violet profond (#7b1fa2, #8e24aa)
- **Ambiance:** Mystérieuse, créative, artistique
- **Usage recommandé:** Design, création de contenu

### 🤖 Cyberpunk
**Style:** Futuriste néon rose et cyan
- **Couleurs primaires:** Rose néon (#ff0080), Cyan (#00ffff)
- **Ambiance:** Futuriste, high-tech, dystopique
- **Usage recommandé:** Hacking éthique, pentesting

## Utilisation

### Dans l'Interface Provisoire

1. Ouvrez l'interface provisoire: `syndra provisional`
2. Allez dans l'onglet **Configuration**
3. Sélectionnez un thème dans le menu déroulant **"Thème visuel"**
4. Le thème est appliqué instantanément

### Dans le Launcher

Le launcher (SUPER + A) utilise automatiquement le thème Iceland par défaut.

### Via Python

```python
from config.themes import get_theme_css, list_themes

# Lister les thèmes
themes = list_themes()
for theme_id, info in themes.items():
    print(f"{info['icon']} {info['name']}: {info['description']}")

# Obtenir le CSS d'un thème
css = get_theme_css("cyberpunk")
```

## Caractéristiques des Interfaces

### ✕ Boutons de Fermeture

Toutes les interfaces disposent maintenant de boutons de fermeture visibles:
- **Bouton rouge avec "✕"** dans le coin supérieur droit
- **Effet hover** pour meilleure visibilité
- **Tooltip** pour confirmation

### 🖱️ Fenêtres Déplaçables

Les headers permettent de déplacer les fenêtres:
- Cliquez et maintenez sur le header
- Déplacez la souris pour repositionner
- Relâchez pour fixer la position

### ⌨️ Raccourcis Clavier

- **ESC** - Fermer la fenêtre (launcher)
- **Ctrl+Q** - Quitter l'application
- **SUPER+A** - Ouvrir le launcher

## Personnalisation Avancée

### Créer un Nouveau Thème

Éditez `config/themes.py` et ajoutez votre thème:

```python
THEMES["mon_theme"] = {
    "name": "Mon Thème",
    "description": "Description de mon thème",
    "icon": "🎨",
    "colors": {
        "primary": "#hexcolor",
        "secondary": "#hexcolor",
        "accent": "#hexcolor",
        "background": "#hexcolor",
        "surface": "#hexcolor",
        "text": "#hexcolor",
        "text_secondary": "#hexcolor",
        "border": "#hexcolor",
        "shadow": "rgba(...)",
        "gradient_start": "#hexcolor",
        "gradient_end": "#hexcolor"
    }
}
```

### Modifier un Thème Existant

Les thèmes sont définis dans `config/themes.py`. Modifiez les valeurs hexadécimales pour ajuster les couleurs.

## Architecture Technique

### Fichiers Concernés

- `config/themes.py` - Définitions des thèmes
- `provisional_interface.py` - Interface avec sélecteur de thème
- `modules/launcher.py` - Launcher avec thème Iceland
- `styles/colors.css` - Styles de base (legacy)

### CSS Dynamique

Le système génère dynamiquement le CSS en fonction du thème sélectionné:

```python
def get_theme_css(theme_name):
    theme = THEMES[theme_name]
    colors = theme["colors"]
    return f"""
    window {{
        background: linear-gradient(...);
        border: 3px solid {colors['primary']};
    }}
    ...
    """
```

### Application en Temps Réel

Les thèmes sont appliqués via GTK StyleContext:

```python
css_provider = Gtk.CssProvider()
css_provider.load_from_data(css.encode())
screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen, css_provider, 
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)
```

## Exemples d'Usage

### Changer de Thème selon l'Heure

```python
import datetime
from config.themes import get_theme_css

hour = datetime.datetime.now().hour
if 6 <= hour < 18:
    theme = "iceland"  # Jour
else:
    theme = "tokyo_night"  # Nuit
```

### Thème Adapté au Profil de Sécurité

- **Blue Team** → Iceland, Forest
- **Red Team** → Sunset, Cyberpunk
- **Purple Team** → Purple Haze
- **CTF/Root** → Tokyo Night, Cyberpunk

## Dépannage

### Le thème ne s'applique pas

1. Vérifiez que `config/themes.py` existe
2. Redémarrez l'interface: `syndra restart`
3. Vérifiez les logs: Check terminal output

### Couleurs incorrectes

- Assurez-vous d'utiliser des valeurs hexadécimales valides
- Format: `#RRGGBB` ou `rgba(r, g, b, a)`

### Performance

Les changements de thème sont instantanés et n'affectent pas les performances. Si vous rencontrez des ralentissements, vérifiez:
- Version de GTK3
- Pilotes graphiques
- Mémoire disponible

## Contribution

Pour proposer un nouveau thème:

1. Créez votre palette dans `config/themes.py`
2. Testez dans les deux interfaces
3. Prenez des captures d'écran
4. Soumettez une PR avec documentation

## License

Thèmes Syndra © 2026 - Distribué sous même license que Syndra

---

**Note:** Les thèmes sont conçus pour être accessibles et respecter les normes WCAG pour le contraste des couleurs.
