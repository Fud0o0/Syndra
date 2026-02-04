# 🎨 Guide de Personnalisation des Thèmes Syndra

## Changement Rapide de Thème

### Via l'Interface Provisoire
```bash
syndra provisional
```
1. Ouvrez l'onglet **Configuration**
2. Sélectionnez un thème dans le menu **"Thème visuel"**
3. Le thème s'applique instantanément

### Via la Configuration

Éditez `~/.config/SyndraShell/config/provisional_config.json` :
```json
{
    "theme": "iceland",
    "autostart": true,
    "transparency": 80
}
```

Thèmes disponibles: `iceland`, `tokyo_night`, `sunset`, `forest`, `purple_haze`, `cyberpunk`

## Personnalisation Avancée

### Créer Votre Propre Thème

1. **Ouvrez** `config/themes.py`
2. **Ajoutez** votre thème au dictionnaire `THEMES`:

```python
THEMES["mon_theme_perso"] = {
    "name": "Mon Thème Perso",
    "description": "Un thème unique et personnalisé",
    "icon": "🎨",
    "colors": {
        "primary": "#FF5733",           # Couleur principale
        "secondary": "#C70039",          # Couleur secondaire
        "accent": "#FFC300",             # Couleur d'accent
        "background": "#F0F8FF",         # Fond principal
        "surface": "#FFFFFF",            # Surface des widgets
        "text": "#333333",               # Texte principal
        "text_secondary": "#666666",     # Texte secondaire
        "border": "#DDDDDD",             # Bordures
        "shadow": "rgba(0,0,0,0.2)",    # Ombres
        "gradient_start": "#FFE5E5",     # Début du gradient
        "gradient_end": "#FFD1D1"        # Fin du gradient
    }
}
```

3. **Sauvegardez** et relancez l'interface

### Modifier un Thème Existant

Pour ajuster un thème existant, modifiez directement ses couleurs dans `config/themes.py`.

**Exemple** - Rendre Iceland plus foncé:
```python
"iceland": {
    ...
    "colors": {
        "primary": "#01579b",        # Plus foncé
        "background": "#b3e5fc",     # Moins lumineux
        ...
    }
}
```

## Palette de Couleurs Recommandée

### Outils de Génération de Palette

- [Coolors.co](https://coolors.co/) - Générateur de palettes
- [Adobe Color](https://color.adobe.com/) - Roue chromatique
- [Material Design Colors](https://materialui.co/colors) - Palettes Material

### Structure de Palette

Pour un thème cohérent, suivez cette structure:

1. **Primary** - Couleur dominante (headers, boutons importants)
2. **Secondary** - Soutient la primary (hover, focus)
3. **Accent** - Attire l'attention (notifications, highlights)
4. **Background** - Fond général de l'interface
5. **Surface** - Cartes, panels, zones de contenu
6. **Text** - Texte principal (doit contraster avec background)
7. **Text Secondary** - Texte moins important
8. **Border** - Séparateurs et bordures
9. **Shadow** - Ombres portées (utiliser rgba pour transparence)
10. **Gradients** - Dégradés pour effets visuels

### Contraste et Accessibilité

Assurez-vous que votre thème respecte les ratios de contraste WCAG:

- **Texte normal** : Ratio minimum de 4.5:1
- **Texte large** : Ratio minimum de 3:1
- **Éléments UI** : Ratio minimum de 3:1

**Testez avec:** [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)

## Exemples de Palettes

### Thème Hacker Green (Matrix Style)
```python
"hacker_green": {
    "name": "Hacker Green",
    "icon": "💻",
    "colors": {
        "primary": "#00ff41",
        "secondary": "#00cc33",
        "accent": "#39ff14",
        "background": "#0d0208",
        "surface": "#1a1a1a",
        "text": "#00ff41",
        "text_secondary": "#00cc33",
        "border": "#003b00",
        "shadow": "rgba(0, 255, 65, 0.3)",
        "gradient_start": "#001a00",
        "gradient_end": "#003300"
    }
}
```

### Thème Dracula
```python
"dracula": {
    "name": "Dracula",
    "icon": "🧛",
    "colors": {
        "primary": "#bd93f9",
        "secondary": "#ff79c6",
        "accent": "#50fa7b",
        "background": "#282a36",
        "surface": "#44475a",
        "text": "#f8f8f2",
        "text_secondary": "#6272a4",
        "border": "#6272a4",
        "shadow": "rgba(189, 147, 249, 0.3)",
        "gradient_start": "#bd93f9",
        "gradient_end": "#ff79c6"
    }
}
```

### Thème Nord
```python
"nord": {
    "name": "Nord",
    "icon": "❄️",
    "colors": {
        "primary": "#88c0d0",
        "secondary": "#81a1c1",
        "accent": "#a3be8c",
        "background": "#2e3440",
        "surface": "#3b4252",
        "text": "#eceff4",
        "text_secondary": "#d8dee9",
        "border": "#4c566a",
        "shadow": "rgba(136, 192, 208, 0.3)",
        "gradient_start": "#88c0d0",
        "gradient_end": "#81a1c1"
    }
}
```

## Application sur Différents Composants

### Headers
Utilisent `primary` et `secondary` en gradient:
```css
background: linear-gradient(135deg, primary 0%, secondary 100%);
```

### Boutons
Gradients subtils avec `surface` et `gradient_start`:
```css
background: linear-gradient(180deg, surface 0%, gradient_start 100%);
border: 2px solid border;
```

### Entrées de Texte (Input)
Fond clair avec bordure accentuée au focus:
```css
background-color: surface;
border: 2px solid border;
/* Au focus */
border-color: primary;
box-shadow: 0 0 8px shadow;
```

### Onglets (Tabs)
État normal vs sélectionné:
```css
/* Normal */
background: linear-gradient(180deg, accent 0%, border 100%);
/* Sélectionné */
background: linear-gradient(180deg, primary 0%, secondary 100%);
color: white;
```

## Animation des Transitions

Pour des transitions fluides entre thèmes, ajoutez ceci dans le CSS:

```css
* {
    transition: all 0.3s ease;
}
```

## Scripts Utiles

### Test de Thème en Python

Créez `test_theme.py`:
```python
#!/usr/bin/env python3
from config.themes import get_theme_css, list_themes

# Lister tous les thèmes
print("Thèmes disponibles:")
for theme_id, info in list_themes().items():
    print(f"  {info['icon']} {info['name']}")

# Tester un thème
theme = "iceland"
css = get_theme_css(theme)
print(f"\nCSS pour {theme}:")
print(css[:200] + "...")
```

Exécutez: `python test_theme.py`

### Export de Thème

Exportez un thème en fichier CSS standalone:
```python
#!/usr/bin/env python3
from config.themes import get_theme_css

theme_name = "iceland"
css = get_theme_css(theme_name)

with open(f"theme_{theme_name}.css", "w") as f:
    f.write(css)

print(f"Thème exporté: theme_{theme_name}.css")
```

## Troubleshooting

### Le thème ne se charge pas
1. Vérifiez la syntaxe Python dans `themes.py`
2. Assurez-vous que toutes les couleurs sont valides
3. Redémarrez l'interface: `syndra restart`

### Couleurs incorrectes
- Les couleurs doivent être en format `#RRGGBB`
- Les ombres utilisent `rgba(R, G, B, A)` où A est l'opacité (0-1)

### Performance lente
- Évitez les dégradés trop complexes
- Limitez les ombres portées
- Utilisez des couleurs opaques quand possible

## Partage de Thèmes

Pour partager votre thème avec la communauté:

1. Créez un fichier JSON avec votre configuration
2. Prenez des captures d'écran
3. Soumettez une PR sur GitHub avec:
   - Le code du thème
   - 3-4 screenshots
   - Description et cas d'usage

---

**💡 Astuce:** Utilisez `syndra provisional` pour tester vos thèmes en temps réel avant de les finaliser.

**🔗 Ressources:**
- [Documentation complète](THEMES.md)
- [Galerie de thèmes](https://fud0o0.github.io/Syndra/themes.html)
- [Discord Community](https://discord.gg/pbrrd5ATK5)
