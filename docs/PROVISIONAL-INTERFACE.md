# Interface Provisoire Syndra

## 📖 À propos

L'interface provisoire est un outil de développement et de test pour SyndraShell. Elle permet de :

- **Tester les modules** sans nécessiter un environnement Hyprland complet
- **Développer et déboguer** l'interface dans un environnement isolé
- **Configurer rapidement** les thèmes et paramètres
- **Visualiser** les composants avant leur déploiement

## 🚀 Installation

L'interface provisoire est automatiquement installée avec la base Syndra :

```bash
curl -fsSL https://raw.githubusercontent.com/Fud0o0/Syndra/main/docs/get/blue.sh | bash
# ou purple.sh, red.sh, root.sh
```

Ou avec l'installation de base uniquement :

```bash
curl -fsSL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh | bash
```

**💡 Note :** Pendant l'installation, il vous sera demandé si vous souhaitez :
1. Lancer l'interface immédiatement après l'installation
2. Configurer le lancement automatique au démarrage

## 🎯 Lancement

### Méthode 1 : Menu d'applications
Cherchez "Syndra Provisional Interface" dans votre lanceur d'applications

### Méthode 2 : Script de lancement
```bash
~/.config/SyndraShell/launch-provisional.sh
```

### Méthode 3 : Directement avec Python
```bash
python ~/.config/SyndraShell/provisional_interface.py
```

## 📋 Fonctionnalités

### Onglet Système
- Affiche les informations système de base
- Utilisateur, répertoire home, shell
- Distribution et framework utilisés
- Bouton de rafraîchissement

### Onglet Modules
Liste et permet de tester tous les modules SyndraShell :
- **Bar** : Barre supérieure
- **Dock** : Dock d'applications
- **Notch** : Zone de notifications
- **Dashboard** : Tableau de bord
- **Wallpapers** : Gestion des fonds d'écran
- **Icons** : Gestionnaire d'icônes

Chaque module dispose d'un bouton "Tester" pour simuler son fonctionnement.

### Onglet Configuration
Options de configuration rapide :
- **Thème** : Blue Team / Red Team / Purple Team / Root Me
- **Mode sombre** : Activer/désactiver
- **Transparence** : Ajuster de 0 à 100%
- **Lancement au démarrage** : Configurer l'autostart (nouveau !)

## 🔄 Lancement Automatique

### Via l'interface
1. Ouvrez l'interface provisoire
2. Allez dans l'onglet "Configuration"
3. Activez le commutateur "Lancement au démarrage"

### Manuellement
Le fichier d'autostart se trouve dans :
```
~/.config/autostart/syndra-provisional.desktop
```

Pour activer :
```bash
cp ~/.local/share/applications/syndra-provisional.desktop ~/.config/autostart/
```

Pour désactiver :
```bash
rm ~/.config/autostart/syndra-provisional.desktop
```

### Via le script utilitaire
Un script dédié facilite la gestion :
```bash
# Afficher l'état
~/.config/SyndraShell/manage-autostart.sh status

# Activer
~/.config/SyndraShell/manage-autostart.sh enable

# Désactiver
~/.config/SyndraShell/manage-autostart.sh disable

# Basculer (toggle)
~/.config/SyndraShell/manage-autostart.sh toggle
```

## 🔧 Utilisation pour le développement

### Tests rapides
Utilisez l'interface pour tester rapidement des modifications sans relancer tout Hyprland :

```python
# Modifiez modules/bar.py
# Puis relancez l'interface pour voir les changements
python ~/.config/SyndraShell/provisional_interface.py
```

### Débogage
L'interface utilise GTK3 natif, ce qui facilite le débogage avec des outils comme :
```bash
GTK_DEBUG=interactive python ~/.config/SyndraShell/provisional_interface.py
```

### Logs
Les logs de l'interface apparaissent dans l'onglet Configuration, section Logs.

## 🎨 Personnalisation

L'interface provisoire peut être personnalisée en modifiant directement :
```
~/.config/SyndraShell/provisional_interface.py
```

### Ajouter un nouveau module de test
```python
def create_modules_page(self, notebook):
    modules_list = [
        # ... modules existants
        ("MonNouveauModule", "Description", "modules.nouveau"),
    ]
```

### Ajouter une option de configuration
```python
def create_config_page(self, notebook):
    # Ajouter après les options existantes
    nouvelle_option = Gtk.CheckButton(label="Mon option")
    config_options.pack_start(nouvelle_option, False, False, 0)
```

## 📝 Notes importantes

1. **Non destiné à la production** : Cette interface est un outil de développement
2. **Requiert GTK3** : Installé automatiquement avec les dépendances Syndra
3. **Indépendant de Hyprland** : Peut fonctionner sur n'importe quel environnement avec GTK
4. **Données de test** : Les informations affichées sont à titre indicatif

## 🐛 Dépannage

### L'interface ne se lance pas
```bash
# Vérifier que Python GTK3 est installé
python -c "import gi; gi.require_version('Gtk', '3.0'); from gi.repository import Gtk"

# Vérifier les permissions
chmod +x ~/.config/SyndraShell/provisional_interface.py
```

### Erreur "module not found"
```bash
# Réinstaller les dépendances Python
cd ~/.config/SyndraShell
pip install --user --break-system-packages -r requirements.txt
```

### L'interface est trop petite/grande
Modifiez la taille par défaut dans le code :
```python
self.set_default_size(800, 600)  # Changez ces valeurs
```

## 🔗 Liens utiles

- [Documentation Syndra](../README.md)
- [GTK3 Documentation](https://docs.gtk.org/gtk3/)
- [Installation complète](INSTALLATION.md)

## 📧 Support

Pour les problèmes spécifiques à l'interface provisoire :
1. Vérifiez les logs dans l'onglet Configuration
2. Consultez la documentation GTK3
3. Ouvrez une issue sur GitHub avec le tag `provisional-interface`
