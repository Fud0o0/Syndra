# Guide de Contrôle de l'Interface Provisoire

## 🚀 Lancement

### Méthodes de lancement
```bash
# 1. Via le menu d'applications
# Cherchez "Syndra Provisional Interface"

# 2. Via le script dédié
~/.config/SyndraShell/launch-provisional.sh

# 3. Directement avec Python
python ~/.config/SyndraShell/provisional_interface.py

# 4. Avec le script de test (vérifie les dépendances)
python ~/.config/SyndraShell/test-provisional.py
```

## 🔄 Lancement Automatique

### Activer/Désactiver via l'interface
1. Ouvrez l'interface provisoire
2. Allez dans l'onglet "Configuration"
3. Utilisez le commutateur "Lancement au démarrage"

### Activer/Désactiver via le terminal

```bash
# Afficher l'état actuel
~/.config/SyndraShell/manage-autostart.sh status

# Activer l'autostart
~/.config/SyndraShell/manage-autostart.sh enable

# Désactiver l'autostart
~/.config/SyndraShell/manage-autostart.sh disable

# Basculer l'état
~/.config/SyndraShell/manage-autostart.sh toggle
```

### Gestion manuelle des fichiers

```bash
# Fichier source
SOURCE="~/.local/share/applications/syndra-provisional.desktop"

# Fichier autostart
AUTOSTART="~/.config/autostart/syndra-provisional.desktop"

# Activer
cp "$SOURCE" "$AUTOSTART"

# Désactiver
rm "$AUTOSTART"

# Vérifier l'état
[ -f "$AUTOSTART" ] && echo "Activé" || echo "Désactivé"
```

## ⚙️ Pendant l'Installation

L'installation vous propose automatiquement :

### 1. Lancement au démarrage
```
Voulez-vous lancer l'interface provisoire au démarrage? [y/N]:
```
- Répondez **y** pour activer l'autostart
- Répondez **n** ou appuyez sur Entrée pour ignorer

### 2. Lancement immédiat
```
🎨 Voulez-vous lancer l'interface provisoire maintenant? [Y/n]:
```
- Répondez **Y** ou appuyez sur Entrée pour lancer
- Répondez **n** pour ne pas lancer maintenant

## 🛑 Arrêt de l'Interface

### Fermer l'interface en cours d'exécution
```bash
# Trouver le processus
ps aux | grep provisional_interface

# Arrêter proprement
pkill -f provisional_interface.py

# Forcer l'arrêt si nécessaire
pkill -9 -f provisional_interface.py
```

### Via l'interface graphique
Fermez simplement la fenêtre avec le bouton X ou Alt+F4

## 🔍 Vérification

### Vérifier si l'interface est en cours d'exécution
```bash
pgrep -f provisional_interface && echo "En cours" || echo "Arrêtée"
```

### Vérifier l'autostart
```bash
if [ -f ~/.config/autostart/syndra-provisional.desktop ]; then
    echo "✅ Autostart activé"
else
    echo "❌ Autostart désactivé"
fi
```

### Vérifier les dépendances
```bash
python ~/.config/SyndraShell/test-provisional.py
```

## 📊 Logs et Débogage

### Lancer avec logs détaillés
```bash
# Logs GTK
GTK_DEBUG=interactive python ~/.config/SyndraShell/provisional_interface.py

# Logs Python
python -u ~/.config/SyndraShell/provisional_interface.py 2>&1 | tee interface.log

# Mode verbeux
GTK_DEBUG=all python ~/.config/SyndraShell/provisional_interface.py
```

### Inspecteur GTK
```bash
# Lancer avec l'inspecteur
GTK_DEBUG=interactive python ~/.config/SyndraShell/provisional_interface.py
# Puis Ctrl+Shift+D dans l'interface pour ouvrir l'inspecteur
```

## 🎛️ Options de Configuration

### Via le fichier de configuration
Éditez : `~/.config/SyndraShell/config/provisional_config.json`

```json
{
  "provisional_interface": {
    "window": {
      "width": 1024,
      "height": 768
    },
    "settings": {
      "dark_mode": true,
      "transparency": 80,
      "auto_launch": true
    }
  }
}
```

### Variables d'environnement
```bash
# Forcer un thème GTK
GTK_THEME=Adwaita:dark python provisional_interface.py

# Désactiver les animations
GTK_ENABLE_ANIMATIONS=0 python provisional_interface.py
```

## 🔗 Liens Rapides

- 📖 [Documentation complète](PROVISIONAL-INTERFACE.md)
- 🎨 [Guide de personnalisation](PROVISIONAL-CUSTOMIZATION.md)
- 🏠 [README principal](../README.md)
- 🚀 [Installation rapide](get/README.md)

## ⌨️ Raccourcis Clavier

### Dans l'interface
- `Ctrl+Q` : Quitter
- `Ctrl+Tab` : Changer d'onglet
- `F11` : Plein écran
- `Alt+F4` : Fermer la fenêtre

### Système
```bash
# Créer un alias pour lancer rapidement
echo "alias provisional='python ~/.config/SyndraShell/provisional_interface.py'" >> ~/.bashrc
source ~/.bashrc

# Utilisation
provisional
```

## 🆘 Dépannage

### L'interface ne se lance pas automatiquement
```bash
# Vérifier que le fichier existe
ls -la ~/.config/autostart/syndra-provisional.desktop

# Vérifier les permissions
chmod +x ~/.local/share/applications/syndra-provisional.desktop

# Re-créer l'autostart
~/.config/SyndraShell/manage-autostart.sh enable
```

### L'interface se lance mais disparaît
```bash
# Lancer depuis le terminal pour voir les erreurs
python ~/.config/SyndraShell/provisional_interface.py

# Vérifier les dépendances
python -c "import gi; gi.require_version('Gtk', '3.0')"
```

### Plusieurs instances lancées
```bash
# Arrêter toutes les instances
pkill -f provisional_interface.py

# Relancer une seule instance
python ~/.config/SyndraShell/provisional_interface.py
```
