<div align="center">

# 🐉 SyndraShell

**Environnement de bureau Hyprland orienté cybersécurité**

Interface moderne sur Wayland · Thème qui suit ton fond d'écran · Outils de sécurité conteneurisés par profil

[Discord](https://discord.gg/pbrrd5ATK5) · [Support (Ko-fi)](https://ko-fi.com/syndrashell)

</div>

---

## ✨ Présentation

SyndraShell est un shell de bureau pour **Hyprland** (Wayland), construit avec le framework **Fabric** (Python/GTK3). Il combine une interface épurée et un **toolkit de sécurité conteneurisé**, organisé en profils opérationnels :

- 🖥️ **L'interface tourne sur l'hôte** (barre, dashboard, notch, dock, notifications…)
- 📦 **Les outils de sécurité tournent dans Docker** — isolés, propres, sans polluer le système
- 🎨 **Les couleurs de l'interface s'adaptent automatiquement au fond d'écran**
- 🧩 **Chaque profil** (Blue / Red / Purple / Root-Me / Custom) a son thème, son fond d'écran et sa liste d'outils

---

## 🚀 Installation

> Prérequis : **Arch Linux**, une session **Hyprland**, `git` et `curl`. Docker est installé automatiquement.

Une seule commande, avec le profil de ton choix :

```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) <profil>
```

Exemples :

```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) blue-team
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) red-team
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) purple
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) root-me
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) custom
```

L'installateur (7 étapes, vérifie chaque dépendance) :

1. Vérifie le système et l'espace disque
2. Installe l'AUR helper (`yay`) si absent
3. Installe Hyprland + les dépendances (`awww`, `kitty`, `docker`, `python-fabric`, …)
4. Installe les dépendances Python (`setproctitle`, `watchdog`, `Pillow`, …)
5. Clone Syndra et enregistre ton profil
6. Configure Hyprland, la police, le fond d'écran du profil
7. Télécharge les images Docker des outils du profil

> ⚠️ Après l'installation, **déconnecte-toi et choisis la session Hyprland** (ou tape `Hyprland` depuis un TTY). SyndraShell démarre automatiquement.

---

## 🧩 Profils

| Profil | Couleur | Espace conseillé | Orientation |
|---|---|---|---|
| 🔵 `blue-team` | Bleu | **6 Go** | Défense, détection, analyse |
| 🔴 `red-team` | Rouge | **7 Go** | Pentest, exploitation |
| 🟣 `purple` | Violet | **10 Go** | Red + Blue complet |
| ⚫ `root-me` | Acier | **7 Go** | CTF, reverse, forensics |
| 🟢 `custom` | Vert | **4 Go** + | Outils au choix |
| ⚪ `default` | Bleu nuit | **4 Go** | Base minimale |

Le **profil est fixé à l'installation** : il détermine le thème, le fond d'écran et les outils. Pour en changer, réinstalle avec un autre profil.

---

## 📦 Outils conteneurisés — `syndra-tools`

Tous les outils tournent dans des conteneurs Docker, accessibles via le lanceur `syndra-tools`. Les fichiers sont partagés via `~/syndra-workspace` ↔ `/workspace`.

```bash
syndra-tools                 # liste les outils du profil actif
syndra-tools catalog         # liste les 36 outils disponibles
syndra-tools <outil>         # installe l'outil + ouvre un shell prêt à l'emploi
syndra-tools <outil> [args]  # exécute l'outil une fois (pour scripter)
syndra-tools shell           # shell Kali complet avec /workspace monté
syndra-tools pull            # (re)télécharge toutes les images du profil
syndra-tools customize       # (profil custom) choisir ses outils
syndra-tools update          # met à jour Syndra (git pull + lanceur)
```

Exemples :

```bash
syndra-tools nmap -sV 10.0.0.1          # scan one-shot
syndra-tools john                        # ouvre un shell avec John prêt
syndra-tools shell                       # boîte à outils Kali complète
```

### Outils par profil

- **🔵 blue-team** — `nmap` · `tshark` · `tcpdump` · `wireshark` · `suricata` · `zeek` · `clamav` · `trivy` · `grype` · `lynis` · `nuclei`
- **🔴 red-team** — `kali` · `nmap` · `rustscan` · `metasploit` · `nikto` · `sqlmap` · `gobuster` · `ffuf` · `feroxbuster` · `wpscan` · `nuclei` · `whatweb` · `hydra` · `john` · `hashcat`
- **🟣 purple** — tout blue + red (nmap, metasploit, wireshark, suricata, sqlmap, hashcat, zap…)
- **⚫ root-me** — `kali` · `nmap` · `radare2` · `gdb` · `ghidra` · `binwalk` · `steghide` · `exiftool` · `foremost` · `volatility3` · `john` · `hashcat` · `sqlmap` · `hydra`
- **🟢 custom** — au choix parmi les 36 outils du catalogue

---

## 🎨 Thème & fonds d'écran

- L'interface **dérive ses couleurs du fond d'écran** courant (`~/.current.wall`) — change de fond, l'interface se recolore automatiquement.
- Chaque profil installe son **fond d'écran assorti** (hippocampe Syndra dans la couleur du profil).
- Sélecteur de fonds intégré : ouvre le **dashboard → onglet Wallpapers**.

Les fonds sont dans `assets/wallpapers/` ; le moteur de couleurs est `config/wallpaper_theme.py`.

---

## ⌨️ Raccourcis principaux

| Raccourci | Action |
|---|---|
| `SUPER` + `R` | Terminal (Kitty) |
| `SUPER` + `D` | Lanceur d'applications |
| `SUPER` + `E` | Explorateur de fichiers |
| `SUPER` + `Space` | Basculer flottant |
| `SUPER` + `C` | Fermer la fenêtre |
| `SUPER` + `M` | Quitter Hyprland |

Le dashboard, le launcher et le notch sont aussi accessibles en cliquant sur la barre.

---

## 🔄 Mise à jour

```bash
syndra-tools update
```

Fait un `git pull` du dépôt et recopie le lanceur. Recharge ton interface :

```bash
pkill -f "python.*main.py"; bash ~/.config/SyndraShell/syndrashell.sh &
```

---

## 🗑️ Désinstallation

```bash
# Standard (garde Hyprland, conserve tes wallpapers perso)
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/uninstall.sh)

# Complète (supprime aussi Hyprland + images Docker Syndra)
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/uninstall.sh) --full
```

---

## 📁 Structure du projet

```
SyndraShell/
├── main.py                  # point d'entrée de l'interface
├── syndrashell.sh           # script de démarrage (lancé par Hyprland)
├── install.sh               # installateur (profil en argument)
├── uninstall.sh             # désinstallateur
├── config/
│   ├── themes.py            # palettes de couleurs par profil
│   ├── wallpaper_theme.py   # couleurs dérivées du fond d'écran
│   ├── hypr/hyprland.conf   # configuration Hyprland
│   └── ...
├── modules/                 # widgets (bar, notch, dashboard, dock…)
├── styles/                  # CSS de l'interface
├── assets/
│   ├── wallpapers/          # fonds d'écran par profil
│   └── fonts/               # police tabler-icons
├── containers/              # docker-compose par profil
└── scripts/
    ├── syndra-tools.sh      # lanceur d'outils conteneurisés
    └── install/             # scripts d'installation d'outils par profil
```

---

## 🛠️ Stack technique

- **Hyprland** — compositeur Wayland
- **Fabric** — framework UI Python/GTK3
- **awww** — gestion du fond d'écran Wayland
- **Docker** — isolation des outils de sécurité
- **PIL/Pillow** — extraction des couleurs du fond d'écran

---

## 🤝 Communauté

- 💬 Discord : [discord.gg/pbrrd5ATK5](https://discord.gg/pbrrd5ATK5)
- ☕ Support : [ko-fi.com/syndrashell](https://ko-fi.com/syndrashell)

---

<div align="center">

Construit avec ❤️ et **Fabric** · Pour usage en environnement autorisé uniquement.

</div>
