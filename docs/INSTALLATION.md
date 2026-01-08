# 📋 Guide d'Installation Syndra Shell

## 🎯 Nouvelle Structure Modulaire

Syndra Shell utilise maintenant une **installation en 2 étapes** pour plus de flexibilité et moins d'espace disque gaspillé.

### ✨ Avantages de cette approche

- ✅ **Installation modulaire** : Sépare l'interface des outils
- ✅ **Moins d'espace gaspillé** : Installez uniquement ce dont vous avez besoin
- ✅ **Changement facile** : Switchez entre profiles sans réinstaller la base
- ✅ **Plus rapide** : Installation de base ~5GB au lieu de 15-25GB

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
- 📦 **~5 GB d'espace disque**

---

## 🛠️ Étape 2 : Choix du Profil Team

Une fois la base installée, choisissez votre profil d'outils selon vos besoins :

### 🔵 Blue Team (Défensif) - ~8 GB
```bash
bash scripts/install-blue.sh
```
**Outils installés :**
- IDS/IPS : Snort, Suricata
- Firewall : UFW, iptables, nftables
- Antivirus : ClamAV, Rkhunter, Lynis
- SIEM : Wazuh, Osquery, Zeek
- Monitoring : htop, glances, sysstat
- Analyse : Fail2ban, auditd, logwatch

**Couleur du thème :** Bleu cyan (#00d4ff)

---

### 🔴 Red Team (Offensif) - ~10 GB
```bash
bash scripts/install-red.sh
```
**Outils installés :**
- Network scanning : Nmap, Masscan
- Web security : Burp Suite, ZAP, SQLMap
- Password cracking : Hashcat, John the Ripper
- Exploitation : Metasploit, Hydra
- Reverse engineering : Ghidra, Radare2
- Fuzzing : Gobuster, ffuf, wfuzz
- Python tools : Impacket, CrackMapExec, Bloodhound

**Couleur du thème :** Rouge (#ff0066)

---

### 🟣 Purple Team (Full Spectrum) - ~20 GB
```bash
bash scripts/install-purple.sh
```
**Outils installés :**
- ✅ **TOUS** les outils Blue Team
- ✅ **TOUS** les outils Red Team
- ✅ Configuration firewall + services de sécurité

**Couleur du thème :** Violet (#b366ff)

---

### ⚫ Root Me / CTF - ~13 GB
```bash
bash scripts/install-root.sh
```
**Outils installés :**
- Reverse engineering : GDB, Radare2, Ghidra, pwndbg, GEF
- Pwn : pwntools, ROPgadget, checksec, one_gadget
- Crypto : OpenSSL, hashcat, john
- Forensics : Volatility, Autopsy, binwalk, foremost
- Web exploitation : Burp Suite, SQLMap, gobuster
- Stéganographie : steghide, exiftool
- Émulation : QEMU (x86, ARM, MIPS)

**Extras :**
- 📁 Workspace CTF créé dans `~/CTF/`
- 📚 Repos GitHub utiles clonés
- 🔧 GDB configuré avec pwndbg

**Couleur du thème :** Blanc/Noir (#ffffff)

---

### 🎨 Custom (Personnalisé)
```bash
bash scripts/install-custom.sh
```
Pour créer votre propre profil, copiez un des scripts existants et modifiez-le selon vos besoins.

---

## 🚀 Installation Rapide (Tout-en-Un)

Le script principal `install.sh` guide à travers les 2 étapes automatiquement :

```bash
bash install.sh
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

| Profil | Espace Disque | Orientation | Idéal pour |
|--------|---------------|-------------|------------|
| **Base seule** | ~5 GB | Interface | Test/Démo |
| **Blue Team** | ~13 GB | Défensif | SOC, Admin sys |
| **Red Team** | ~15 GB | Offensif | Pentest, Bug bounty |
| **Purple Team** | ~25 GB | Complet | Recherche, Formation |
| **Root Me** | ~18 GB | CTF/Challenges | CTF, Learning |

---

## 🎨 Thèmes par Profil

Chaque profil applique automatiquement un thème de couleur dans Waybar :

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
