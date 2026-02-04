# Personnalisation de l'Interface Provisoire

## Configuration JSON

L'interface provisoire peut être personnalisée via le fichier :
```
~/.config/SyndraShell/config/provisional_config.json
```

## Options Disponibles

### Fenêtre
```json
"window": {
  "title": "Titre personnalisé",
  "width": 1024,
  "height": 768,
  "position": "center"  // ou "mouse", "topleft", etc.
}
```

### Thèmes
```json
"themes": {
  "available": ["Blue Team", "Red Team", "Purple Team", "Root Me"],
  "default": "Purple Team"
}
```

### Modules
Ajoutez vos propres modules :
```json
"modules": [
  {
    "name": "MonModule",
    "description": "Description du module",
    "module": "modules.monmodule",
    "enabled": true
  }
]
```

### Paramètres
```json
"settings": {
  "dark_mode": true,
  "transparency": 80,
  "auto_launch": false  // Lancer au démarrage
}
```

## Personnalisation du Code

### Ajouter un Onglet

Éditez `provisional_interface.py` et ajoutez dans `__init__` :
```python
self.create_my_tab(notebook)
```

Puis créez la méthode :
```python
def create_my_tab(self, notebook):
    box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
    # Ajoutez vos widgets ici
    notebook.append_page(box, Gtk.Label(label="Mon Onglet"))
```

### Modifier les Couleurs

Les couleurs sont gérées par le thème GTK. Pour forcer des couleurs :
```python
css_provider = Gtk.CssProvider()
css_provider.load_from_data(b"""
    .my-widget {
        background-color: #1a1b26;
        color: #a9b1d6;
    }
""")
```

### Ajouter des Boutons d'Action

```python
button = Gtk.Button(label="Mon Action")
button.connect("clicked", self.on_my_action)

def on_my_action(self, button):
    print("Action exécutée!")
```

## Exemples de Personnalisation

### Interface en Plein Écran
```python
self.fullscreen()
```

### Fenêtre Sans Décoration
```python
self.set_decorated(False)
```

### Transparence de la Fenêtre
```python
screen = self.get_screen()
visual = screen.get_rgba_visual()
if visual:
    self.set_visual(visual)
self.set_app_paintable(True)
```

### Icône Personnalisée
```python
self.set_icon_from_file("/chemin/vers/icon.png")
```

## Intégration avec Syndra

### Lire la Configuration Syndra
```python
import json

with open(os.path.expanduser("~/.config/SyndraShell/config/config.json")) as f:
    config = json.load(f)
    theme = config.get("theme", "purple")
```

### Appeler les Modules Syndra
```python
from modules.bar import Bar
from modules.dock import Dock

# Initialiser un module
bar = Bar()
```

### Utiliser les Utilitaires Syndra
```python
from utils.functions import get_battery_level, get_network_info
from config.data import APP_NAME, HOME_DIR
```

## Débogage

### Mode Verbose
```bash
GTK_DEBUG=interactive python ~/.config/SyndraShell/provisional_interface.py
```

### Logs Détaillés
Ajoutez dans le code :
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Inspector GTK
Lancez avec l'inspecteur :
```bash
GTK_DEBUG=interactive python provisional_interface.py
```
Puis appuyez sur `Ctrl+Shift+D` dans l'interface.

## Ressources

- [Documentation GTK3](https://docs.gtk.org/gtk3/)
- [PyGObject Guide](https://pygobject.readthedocs.io/)
- [Exemples GTK](https://github.com/Taiko2k/GTK3-Python-Examples)
