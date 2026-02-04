# 🎨 Interface Provisoire Syndra - Guide Rapide

## Installation

L'interface provisoire s'installe **automatiquement** avec Syndra :

```bash
curl -L get.syndra.me/purple | sh
```

Pendant l'installation, vous serez invité à :
1. ✅ Activer le lancement au démarrage (optionnel)
2. 🚀 Lancer l'interface immédiatement

## Lancement Rapide

```bash
# Méthode 1: Script dédié
~/.config/SyndraShell/launch-provisional.sh

# Méthode 2: Direct Python
python ~/.config/SyndraShell/provisional_interface.py

# Méthode 3: Menu d'applications
# Cherchez "Syndra Provisional Interface"
```

## Gestion de l'Autostart

```bash
# Voir le statut
~/.config/SyndraShell/manage-autostart.sh status

# Activer
~/.config/SyndraShell/manage-autostart.sh enable

# Désactiver
~/.config/SyndraShell/manage-autostart.sh disable

# Basculer
~/.config/SyndraShell/manage-autostart.sh toggle
```

## Vérification de l'Installation

```bash
# Vérifier que tout est installé correctement
python ~/.config/SyndraShell/verify-provisional.py
```

## Fonctionnalités

### Onglet Système
- Informations utilisateur
- Répertoire home
- Shell et distribution

### Onglet Modules
Tester tous les modules Syndra :
- Bar (barre supérieure)
- Dock (applications)
- Notch (notifications)
- Dashboard
- Wallpapers
- Icons

### Onglet Configuration
- 🎨 Thèmes (Blue/Red/Purple/Root Me)
- 🌙 Mode sombre
- 👁️ Transparence
- 🔄 Lancement au démarrage

## Documentation Complète

- 📖 [Guide complet](docs/PROVISIONAL-INTERFACE.md)
- 🎨 [Personnalisation](docs/PROVISIONAL-CUSTOMIZATION.md)
- 🎛️ [Contrôle avancé](docs/PROVISIONAL-CONTROL.md)

## Dépannage

### L'interface ne se lance pas
```bash
# Vérifier les dépendances
python ~/.config/SyndraShell/test-provisional.py

# Vérifier l'installation complète
python ~/.config/SyndraShell/verify-provisional.py
```

### L'autostart ne fonctionne pas
```bash
# Re-créer le fichier d'autostart
~/.config/SyndraShell/manage-autostart.sh enable

# Vérifier manuellement
ls -la ~/.config/autostart/syndra-provisional.desktop
```

### Voir les erreurs
```bash
# Lancer depuis le terminal pour voir les logs
python ~/.config/SyndraShell/provisional_interface.py
```

## Liens Utiles

- 🏠 [README Principal](README.md)
- 🚀 [Installation Rapide](docs/get/README.md)
- 💬 [Discord](https://discord.gg/pbrrd5ATK5)
- 🐛 [Signaler un bug](https://github.com/Fud0o0/Syndra/issues)
