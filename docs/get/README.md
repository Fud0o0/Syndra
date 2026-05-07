# 🚀 Installation Rapide Syndra Shell

Installez Syndra Shell avec votre profil préféré en **une seule commande** !

**⭐ Nouveau :** Inclut maintenant une interface provisoire GTK pour le développement et les tests !

## 📋 Profils Disponibles

### 🔵 Blue Team (Défensif)

**Outils:** IDS/IPS, Firewall, Antivirus, Monitoring, SIEM  
**Espace:** ~13 GB

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/docs/get/blue.sh
```

Si le dossier existe deja, mettez a jour puis lancez le script:
```bash
git -C ~/.config/SyndraShell pull
bash ~/.config/SyndraShell/docs/get/blue.sh
```

---

### 🔴 Red Team (Offensif)

**Outils:** Pentest, Exploitation, Password cracking, Reverse engineering  
**Espace:** ~15 GB

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/docs/get/red.sh
```

Si le dossier existe deja, mettez a jour puis lancez le script :
```bash
git -C ~/.config/SyndraShell pull
bash ~/.config/SyndraShell/docs/get/red.sh
```

---

### 🟣 Purple Team (Complet)
**Outils:** TOUS les outils Red + Blue  
**Espace:** ~25 GB

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/docs/get/purple.sh
```

Si le dossier existe deja, mettez a jour puis lancez le script :
```bash
git -C ~/.config/SyndraShell pull
bash ~/.config/SyndraShell/docs/get/purple.sh
```

---

### ⚫ Root Me / CTF
**Outils:** Reverse, Pwn, Crypto, Forensics, Web exploitation  
**Espace:** ~18 GB

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/docs/get/root.sh
```

Si le dossier existe deja, mettez a jour puis lancez le script :
```bash
git -C ~/.config/SyndraShell pull
bash ~/.config/SyndraShell/docs/get/root.sh
```

---

## 🎨 Installation de Base Uniquement

Pour installer uniquement l'interface Syndra (sans outils de sécurité) :

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/install.sh
```

Si le dossier existe deja, mettez a jour puis lancez l'installation :
```bash
git -C ~/.config/SyndraShell pull
bash ~/.config/SyndraShell/install.sh
```

---

## 🔧 Ce que fait chaque installation

Toutes les installations incluent :
- ✅ Hyprland + environnement Wayland
- ✅ Syndra Shell (interface complète)
- ✅ Interface provisoire GTK (développement/test)
- ✅ Waybar, Kitty, Wofi, Dunst
- ✅ Configurations optimisées

**Plus les outils spécifiques à chaque profil !**

---

## 🎨 Interface Provisoire

Après l'installation, une interface de test GTK est disponible :

**Lancement :**
```bash
# Via le script
~/.config/SyndraShell/launch-provisional.sh

# Ou directement
python ~/.config/SyndraShell/provisional_interface.py

# Ou via le menu d'applications
# Cherchez "Syndra Provisional Interface"
```

**Utilité :**
- 🧪 Tester les modules sans Hyprland
- ⚙️ Configuration rapide (thèmes, modes)
- 🔍 Développement et débogage
- 📊 Vue d'ensemble du système

[📖 Documentation complète](../PROVISIONAL-INTERFACE.md)

---

## 💡 Besoin d'aide ?

- 📖 [Documentation complète](../INSTALLATION.md)
- 💬 [Discord Syndra](https://discord.gg/pbrrd5ATK5)
- 🐛 [Signaler un bug](https://github.com/Fud0o0/Syndra/issues)
- ☕ [Soutenir le projet](https://ko-fi.com/syndrashell)

---

**Installation modulaire • Flexible • Optimisée**
