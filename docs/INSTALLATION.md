# 📋 Guide d'Installation Syndra Shell

> [!IMPORTANT]
> Le flux `curl | bash` est retire.
> Le flux recommande est: `git clone` + `scripts/secure-install.sh`.

## 🎯 Nouvelle Structure Modulaire

Syndra Shell utilise maintenant une **installation en 2 étapes** pour plus de flexibilité et moins d'espace disque gaspillé.

### ✨ Avantages de cette approche

- ✅ **Installation modulaire** : Sépare l'interface des outils
- ✅ **Moins d'espace gaspillé** : Installez uniquement ce dont vous avez besoin
- ✅ **Changement facile** : Switchez entre profiles sans réinstaller la base
- ✅ **Plus rapide** : Installation de base ~3GB au lieu de 15-25GB

---

## 🔐 Installation sécurisée (recommandée)

Pour installer le profil personnalisé (Custom) directement :

```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) custom
```

Ou cloner puis exécuter l'installateur de manière interactive :

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/scripts/secure-install.sh interactive
```

### Profils directs

```bash
bash ~/.config/SyndraShell/scripts/secure-install.sh default
bash ~/.config/SyndraShell/scripts/secure-install.sh blue
bash ~/.config/SyndraShell/scripts/secure-install.sh red
bash ~/.config/SyndraShell/scripts/secure-install.sh purple
bash ~/.config/SyndraShell/scripts/secure-install.sh root
```

### Vérification d'intégrité

```bash
bash ~/.config/SyndraShell/scripts/verify-artifacts.sh
SYNDRA_REQUIRE_SIGNATURE=1 bash ~/.config/SyndraShell/scripts/verify-artifacts.sh
```

---

## 🧱 Outils isolés (Docker/Podman)

Le GUI reste sur l'hôte, les outils sécurité tournent dans un conteneur isolé.

```bash
bash ~/.config/SyndraShell/scripts/container-tools.sh purple build
bash ~/.config/SyndraShell/scripts/container-tools.sh purple run
```

Volumes partagés par défaut:

- `~/.local/share/syndra-tools/workspace`
- `~/.local/share/syndra-tools/reports`
- `~/.local/share/syndra-tools/wordlists`
- `~/.local/share/syndra-tools/loot`

---

## 📦 Étape 1 : Installation de Base

Le script `install-syndra-base.sh` installe **uniquement** l'environnement Hyprland et Syndra Shell :

```bash
bash scripts/install-syndra-base.sh
```

### Ce qui est installé :
- 🎨 **Hyprland** + composants Wayland (hyprlock, hypridle, etc.)
- 🖥️ **Interface Syndra** (waybar, wofi, kitty, dunst)
- 🐍 **Dépendances Python** pour Syndra
- 🔗 **Configurations** de base et liens symboliques
- 📦 **~3 GB d'espace disque**

---

## 🛠️ Étape 2 : Choix du Profil Team

Une fois la base installée, choisissez votre profil d'outils selon vos besoins :

### ⚪ Default (Outils de Base) - ~0.15 Go (Docker) | ~3.2 Go (Total) | 4 Go conseillé
```bash
# Inclus par défaut avec la base
```
**Outils installés :**
- Kali Linux (Conteneur)
- Nmap (Conteneur)

**Couleur du thème :** Bleu foncé (#1d4ed8)

---

### 🔵 Blue Team (Défensif) - ~2.3 Go (Docker) | ~5.3 Go (Total) | 6 Go conseillé
```bash
bash scripts/install-blue.sh
```
**Outils installés :**
- Réseau & Capture : Nmap, Tshark, Tcpdump, Wireshark
- Détection & Analyse : Suricata (IDS/IPS), Zeek
- Audit Système & Antivirus : ClamAV (antivirus), Lynis (audit système)
- Analyse de vulnérabilités : Trivy, Grype (scan vuln conteneurs), Nuclei

**Couleur du thème :** Bleu cyan (#00d4ff)

---

### 🔴 Red Team (Offensif) - ~3.2 Go (Docker) | ~6.2 Go (Total) | 7 Go conseillé
```bash
bash scripts/install-red.sh
```
**Outils installés :**
- Reconnaissance & Scan : Kali, Nmap, Rustscan, WhatWeb
- Exploitation : Metasploit, SQLmap
- Sécurité Web : Nikto, Gobuster, Ffuf, Feroxbuster, WPScan, Nuclei
- Mots de passe & Auth : Hydra, John, Hashcat

**Couleur du thème :** Rouge (#ff0066)

---

### 🟣 Purple Team (Full Spectrum) - ~6.3 Go (Docker) | ~9.3 Go (Total) | 10 Go conseillé
```bash
bash scripts/install-purple.sh
```
**Outils installés :**
- Reconnaissance & Scan Web : Kali, Nmap, Rustscan, Nikto, Gobuster, WPScan, Nuclei
- Exploitation & Mots de passe : Metasploit, SQLmap, Hydra, John, Hashcat
- Réseau & Détection : Wireshark, Tshark, Suricata
- Audit & Analyse : ClamAV, Trivy, Zap (OWASP ZAP)

**Couleur du thème :** Violet (#b366ff)

---

### ⚫ Root Me / CTF - ~3.6 Go (Docker) | ~6.6 Go (Total) | 7 Go conseillé
```bash
bash scripts/install-root.sh
```
**Outils installés :**
- Reconnaissance & Exploitation : Gdb, SQLmap, Hydra, Kali, Nmap
- Reverse Engineering : Radare2, Ghidra
- Forensics & Extraction : Binwalk, Exiftool, Foremost, Volatility3
- Mots de passe & Stéganographie : Steghide, John, Hashcat

**Extras :**
- 📁 Workspace CTF créé dans `~/CTF/`
- 📚 Repos GitHub utiles clonés
- 🔧 GDB configuré avec pwndbg

**Couleur du thème :** Blanc/Noir (#ffffff)

---

### 🎨 Custom (Personnalisé) - 0.1–6 Go (Docker) | variable | 4 Go mini
```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) custom
```
Base : kali + nmap. L'utilisateur sélectionne ses outils à l'install (ou via `syndra-tools customize`).

---

## 🚀 Installation Rapide (Tout-en-Un)

Le script principal `install.sh` guide à travers les 2 étapes automatiquement :

```bash
bash ~/.config/SyndraShell/install.sh
```

### Le script va :
1. ✅ Vérifier si la base est installée
2. ✅ Installer la base si nécessaire
3. ✅ Proposer le choix du profil team
4. ✅ Installer les outils choisis
5. ✅ Afficher les instructions finales

---

## 🔄 Changer de Profil Team

Vous pouvez changer de profil à tout moment sans réinstaller la base :

```bash
# Passer de Blue Team à Red Team par exemple
bash scripts/install-red.sh

# Ou passer à Purple Team (full)
bash scripts/install-purple.sh
```

> ⚠️ **Note :** Les outils du profil précédent ne sont pas désinstallés, ils s'ajoutent.

---

## 📊 Comparaison des Profils

| Profil | Images Docker | + Base (~3 Go) | Minimum conseillé |
|--------|---------------|----------------|-------------------|
| **Default** | ~0.15 Go | ~3.2 Go | 4 Go |
| **Blue Team** | ~2.3 Go | ~5.3 Go | 6 Go |
| **Red Team** | ~3.2 Go | ~6.2 Go | 7 Go |
| **Purple Team** | ~6.3 Go | ~9.3 Go | 10 Go |
| **Root Me** | ~3.6 Go | ~6.6 Go | 7 Go |
| **Custom** | 0.1–6 Go | variable | 4 Go mini |

---

## 🎨 Thèmes par Profil

Chaque profil applique automatiquement un thème de couleur dans Waybar :

- ⚪ **Default** : Bleu foncé (#1d4ed8)
- 🔵 **Blue Team** : Cyan (#00d4ff)
- 🔴 **Red Team** : Rouge (#ff0066)  
- 🟣 **Purple Team** : Violet (#b366ff)
- ⚫ **Root Me** : Blanc (#ffffff)

---

## 🔧 Post-Installation

Après l'installation :

1. **Déconnectez-vous** de votre session
2. **Sélectionnez Hyprland** dans votre gestionnaire de connexion
3. **Connectez-vous**
4. Syndra Shell démarre automatiquement

### Raccourcis clavier

- `SUPER + D` → Dashboard Syndra
- `SUPER + R` → Lanceur d'applications (Wofi)
- `SUPER + Enter` → Terminal (Kitty)
- `SUPER + Q` → Fermer la fenêtre active

---

## 🆘 Dépannage

### La base ne s'installe pas
```bash
# Vérifier que vous êtes sur Arch Linux
cat /etc/arch-release

# Vérifier l'espace disque
df -h
```

### Un script team échoue
Les scripts team continuent même si certains paquets échouent. Vérifiez les messages d'erreur et installez manuellement les paquets manquants si nécessaire.

### Mettre à jour Syndra
```bash
cd ~/.config/SyndraShell
git pull
bash install.sh  # Choisir option 1 pour mettre à jour la base
```

---

## 📚 Documentation

- [README principal](../README.md)
- [Documentation complète](../docs/)
- [Dépendances](../docs/DEPENDENCIES.md)
- [Guide d'utilisation](../docs/USAGE.md)

---

## 🤝 Contribution

Si vous créez un profil custom intéressant, n'hésitez pas à le partager via une Pull Request !

---

**Créé avec ❤️ pour la communauté cybersécurité**
