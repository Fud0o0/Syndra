# SyndraShell

SyndraShell est un environnement Hyprland orienté cybersécurité, pensé pour un usage quotidien et des profils opérationnels (Blue, Red, Purple, Root/CTF).

Le projet sépare maintenant clairement :

- le GUI sur l'hôte (Hyprland, interface Syndra)
- les outils sécurité dans des conteneurs isolés (Docker ou Podman)

## Pourquoi ce changement

- plus de flux `curl | bash`
- vérification d'intégrité SHA256 avant installation
- vérification de signature possible en mode strict
- isolation outillage offensive/défensive par profil

## Prérequis

- Arch Linux pour l'installation GUI complète
- git
- Hyprland fonctionnel
- Docker ou Podman si vous utilisez le mode outils conteneurisés

## Installation recommandée (sécurisée)

Pour installer le profil personnalisé (Custom) directement :

```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/install.sh) custom
```

Ou cloner puis exécuter l'installateur de manière interactive :

```bash
git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell
bash ~/.config/SyndraShell/scripts/secure-install.sh interactive
```

### Installation directe par profil

```bash
bash ~/.config/SyndraShell/scripts/secure-install.sh default
bash ~/.config/SyndraShell/scripts/secure-install.sh blue
bash ~/.config/SyndraShell/scripts/secure-install.sh red
bash ~/.config/SyndraShell/scripts/secure-install.sh purple
bash ~/.config/SyndraShell/scripts/secure-install.sh root
```

## Vérification intégrité et signature

Vérification SHA256 :

```bash
bash ~/.config/SyndraShell/scripts/verify-artifacts.sh
```

Mode strict avec signature obligatoire :

```bash
SYNDRA_REQUIRE_SIGNATURE=1 bash ~/.config/SyndraShell/scripts/verify-artifacts.sh
```

Politique de signature mainteneur : [checksums/SIGNING.md](checksums/SIGNING.md)

## Outils isolés en conteneur (Docker ou Podman)

Le script choisit automatiquement Podman si présent, sinon Docker.

Build d'un profil :

```bash
bash ~/.config/SyndraShell/scripts/container-tools.sh purple build
```

Run d'un profil :

```bash
bash ~/.config/SyndraShell/scripts/container-tools.sh purple run
```

Shell interactif dans le conteneur :

```bash
bash ~/.config/SyndraShell/scripts/container-tools.sh purple shell
```

Volumes partagés par défaut :

- ~/.local/share/syndra-tools/workspace
- ~/.local/share/syndra-tools/reports
- ~/.local/share/syndra-tools/wordlists
- ~/.local/share/syndra-tools/loot

Tu peux changer l'emplacement via `SYNDRA_SHARED_ROOT`.

## Profils disponibles

- Default : minimal avec Kali et Nmap uniquement
- Blue : défense, monitoring, détection
- Red : pentest, exploitation, reverse
- Purple : couverture complète Red + Blue
- Root : CTF, pwn, forensics, crypto

## Interface provisoire

L'interface provisoire est installée avec la base et utile pour tester les modules sans session complète.

```bash
~/.config/SyndraShell/launch-provisional.sh
```

Docs dédiées :

- [docs/PROVISIONAL-INTERFACE.md](docs/PROVISIONAL-INTERFACE.md)
- [docs/PROVISIONAL-CUSTOMIZATION.md](docs/PROVISIONAL-CUSTOMIZATION.md)
- [docs/PROVISIONAL-CONTROL.md](docs/PROVISIONAL-CONTROL.md)

## Raccourcis principaux

- SUPER + A : menu Syndra
- SUPER + D : dashboard
- SUPER + R : launcher
- SUPER + Enter : terminal
- SUPER + Q : fermer fenêtre

## Désinstallation

```bash
bash <(curl -sL https://raw.githubusercontent.com/Fud0o0/Syndra/main/uninstall) --full
```

## Documentation

- [docs/INSTALLATION.md](docs/INSTALLATION.md)
- [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md)
- [docker/README.md](docker/README.md)
- [docs/THEMES.md](docs/THEMES.md)

## Communauté

- Discord : [https://discord.gg/pbrrd5ATK5](https://discord.gg/pbrrd5ATK5)
- Support : [https://ko-fi.com/syndrashell](https://ko-fi.com/syndrashell)

## Crédit

Construit avec Fabric.
