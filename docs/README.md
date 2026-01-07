# 🌐 SyndraShell Web Dashboard

## Comment héberger votre site web

Votre site est maintenant prêt dans le dossier `docs/` ! Voici comment l'héberger gratuitement sur GitHub Pages :

### 📋 Étapes pour activer GitHub Pages

1. **Push votre code sur GitHub** (si ce n'est pas déjà fait) :
   ```bash
   git add .
   git commit -m "Add web dashboard"
   git push origin main
   ```

2. **Activer GitHub Pages** :
   - Allez sur votre repo GitHub : `https://github.com/Fud0o0/SyndraShell`
   - Cliquez sur **Settings** (Paramètres)
   - Dans le menu gauche, cliquez sur **Pages**
   - Sous "Source", sélectionnez :
     - **Branch** : `main`
     - **Folder** : `/docs`
   - Cliquez sur **Save**

3. **Attendez quelques minutes** ⏱️
   - GitHub va construire votre site
   - Votre site sera disponible à : `https://fud0o0.github.io/SyndraShell/`

### ✨ Fonctionnalités du site

- 🎨 **Thèmes dynamiques** : Purple Team / Blue Team
- 💾 **Sauvegarde automatique** : Votre choix est mémorisé
- ✨ **Animations fluides** : Particules et transitions
- 📱 **Responsive** : Fonctionne sur mobile et desktop
- 🔗 **Profil GitHub** : Lien direct vers votre profil

### 🎯 Personnalisation

#### Modifier vos informations :
Dans `docs/index.html`, changez :
- L'URL de l'image : `https://github.com/Fud0o0.png`
- Votre nom d'utilisateur dans les liens
- Le contenu des cartes

#### Ajuster les couleurs :
Dans `docs/style.css`, modifiez les variables CSS :
```css
:root {
    --purple-primary: #8b5cf6;
    --blue-primary: #3b82f6;
}
```

### 🚀 Accéder au site localement

Pour tester avant de push :
```bash
cd docs
python -m http.server 8000
```

Puis ouvrez : `http://localhost:8000`

---

**⚡ Votre site sera accessible à : `https://fud0o0.github.io/SyndraShell/`**
