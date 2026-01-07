# ⚡ SyndraShell

> Un shell puissant pour les opérations de cybersécurité.

---

### 🛠️ Choisissez votre mode d'utilisation :

| [ ![Red Team](https://img.shields.io/badge/RED_TEAM-🔴-red?style=for-the-badge) ](#red-section) | [ ![Blue Team](https://img.shields.io/badge/BLUE_TEAM-🔵-blue?style=for-the-badge) ](#blue-section) | [ ![Purple Team](https://img.shields.io/badge/PURPLE_TEAM-🟣-purple?style=for-the-badge) ](#purple-section) | [ ![Root-Me](https://img.shields.io/badge/ROOT--ME-🟢-green?style=for-the-badge) ](#rootme-section) |
| :---: | :---: | :---: | :---: |

---

<div id="red-section">

## 🔴 Mode Red Team (Attaque)
*Utilisez SyndraShell pour l'exploitation et les tests d'intrusion.*

- **Reverse Shells :** Génération rapide de payloads.
- **Post-Exploitation :** Scripts d'énumération automatique.
- **Exemple :** `syndra --payload python/rev_shell --ip 10.10.10.1`

</div>

---

<div id="blue-section">

## 🔵 Mode Blue Team (Défense)
*Surveillance et sécurisation avec SyndraShell.*

- **Log Analysis :** Analyse des accès suspects en temps réel.
- **Audit :** Vérification des configurations système.
- **Exemple :** `syndra --audit --system-check`

</div>

---

<div id="purple-section">

## 🟣 Mode Purple Team (Collaboratif)
*Le pont entre l'attaque et la détection.*

- **Emulation d'attaques :** Testez vos propres SIEM.
- **Rapport :** Génération de logs de comportement d'attaque.

</div>

---

<div id="rootme-section">

## 🟢 Intégration Root-Me
*Connectez votre progression Root-Me à vos outils.*

- **Challenge Stats :** Affichez vos derniers flags réussis.
- [![Root-Me Stats](https://www.root-me.org/VOTRE_PSEUDO?inc=score&lang=fr)](https://www.root-me.org/VOTRE_PSEUDO)

</div>

---

## 🚀 Installation
```bash
git clone [https://github.com/Fud0o0/SyndraShell](https://github.com/Fud0o0/SyndraShell)
cd SyndraShell
pip install -r requirements.txt