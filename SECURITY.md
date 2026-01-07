# Politique de Sécurité - SyndraShell

## Fichiers Sensibles

Les fichiers suivants sont protégés et ne sont visibles que par les collaborateurs autorisés :

### Fichiers cryptés (git-crypt)

- `config/.env` - Variables d'environnement sensibles
- `config/secrets/*` - Tous les fichiers dans le dossier secrets
- `*.secret` - Fichiers avec extension .secret
- `*.key` - Clés privées
- `api_keys.json` - Clés API
- `tokens.json` - Tokens d'authentification

### Configuration de git-crypt

Pour accéder aux fichiers sensibles en tant que collaborateur :

1. Installez git-crypt :

   ```bash
   # Arch Linux
   sudo pacman -S git-crypt
   
   # Ubuntu/Debian
   sudo apt install git-crypt
   ```

2. Demandez au propriétaire du repo de vous ajouter comme collaborateur :

   ```bash
   git-crypt add-gpg-user VOTRE_GPG_KEY_ID
   ```

3. Déverrouillez le repo :

   ```bash
   git-crypt unlock
   ```

### Pour les nouveaux projets

Le propriétaire doit initialiser git-crypt :

```bash
cd ~/.config/SyndraShell
git-crypt init
git-crypt add-gpg-user VOTRE_GPG_KEY_ID
```

## Fichiers Ignorés

Les fichiers suivants sont complètement ignorés par Git (.gitignore) :

- Logs (`*.log`)
- Fichiers temporaires (`*.tmp`)
- Cache Python (`__pycache__/`, `*.pyc`)
- Bases de données locales (`*.db`, `*.sqlite`)
- Configurations utilisateur personnalisées

## Bonnes Pratiques

1. **Ne jamais commiter** de clés API, tokens, ou mots de passe en clair
2. Utiliser `.env` pour les variables d'environnement sensibles
3. Utiliser `config.example.json` comme template sans données sensibles
4. Vérifier avec `git diff` avant chaque commit

## Reporting de Vulnérabilités

Si vous découvrez une vulnérabilité, contactez : [votre email]
