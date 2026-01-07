# 🌐 Configurer un Domaine Personnalisé pour GitHub Pages

## 📌 Options de Domaines Gratuits

### Option 1 : Sous-domaines gratuits (Recommandé)

#### **is-a.dev** (Meilleur pour développeurs)
- ✅ Domaine : `fudooo.is-a.dev` ou `syndrashell.is-a.dev`
- ✅ Gratuit à vie
- ✅ HTTPS automatique
- 🔗 Site : https://is-a-dev.com

**Comment obtenir :**
1. Fork le repo : https://github.com/is-a-dev/register
2. Créez un fichier `domains/votre-nom.json` :
```json
{
  "owner": {
    "username": "Fud0o0",
    "email": "votre@email.com"
  },
  "record": {
    "CNAME": "fud0o0.github.io"
  }
}
```
3. Créez une Pull Request
4. Attendez l'approbation (1-2 jours)

#### **js.org** (Pour projets JavaScript)
- ✅ Domaine : `fudooo.js.org`
- 🔗 Site : https://js.org

#### **thedev.id** (Pour développeurs)
- ✅ Domaine : `fudooo.thedev.id`
- 🔗 Site : https://thedev.id

### Option 2 : Domaines complètement gratuits

#### **Freenom** (Domaines gratuits 1 an)
- ✅ Extensions : `.tk`, `.ml`, `.ga`, `.cf`, `.gq`
- 📝 Exemple : `fudooo.tk` ou `syndrashell.ml`
- 🔗 Site : https://www.freenom.com
- ⚠️ Renouvelable chaque année (peut être supprimé si inactif)

#### **eu.org** (Gratuit à vie)
- ✅ Domaine : `fudooo.eu.org`
- 🔗 Site : https://nic.eu.org
- ⏱️ Validation manuelle (peut prendre 2-4 semaines)

---

## ⚙️ Configuration GitHub Pages avec Domaine Personnalisé

### Étape 1 : Créer le fichier CNAME

Dans le dossier `docs/`, créez un fichier `CNAME` contenant votre domaine :

```
fudooo.is-a.dev
```

ou

```
fudooo.tk
```

### Étape 2 : Configurer le DNS

#### Pour is-a.dev, js.org, thedev.id :
Rien à faire ! Ils configurent tout pour vous.

#### Pour Freenom ou domaine acheté :

1. **Allez dans les paramètres DNS de votre domaine**

2. **Ajoutez ces enregistrements DNS :**

**Pour un domaine racine (fudooo.tk) :**
```
Type: A
Name: @
Value: 185.199.108.153

Type: A
Name: @
Value: 185.199.109.153

Type: A
Name: @
Value: 185.199.110.153

Type: A
Name: @
Value: 185.199.111.153
```

**Pour un sous-domaine (www.fudooo.tk) :**
```
Type: CNAME
Name: www
Value: fud0o0.github.io
```

### Étape 3 : Activer HTTPS sur GitHub

1. Allez sur votre repo : `https://github.com/Fud0o0/SyndraShell`
2. **Settings** → **Pages**
3. Dans "Custom domain", entrez votre domaine : `fudooo.is-a.dev`
4. Cliquez sur **Save**
5. Attendez quelques minutes
6. ✅ Cochez **Enforce HTTPS**

---

## 🎯 Recommandation pour vous

### Solution la plus simple : **is-a.dev**

```bash
# 1. Créez le fichier CNAME
echo "syndrashell.is-a.dev" > docs/CNAME

# 2. Push sur GitHub
git add docs/CNAME
git commit -m "Add custom domain"
git push origin main

# 3. Demandez le sous-domaine sur is-a-dev
```

**Votre site sera accessible à : `https://syndrashell.is-a.dev` 🚀**

---

## 🚨 Domaines .fr

⚠️ Les domaines `.fr` ne sont **PAS gratuits**. Ils coûtent environ :
- **8-12€/an** chez OVH, Gandi, etc.

Si vous voulez vraiment un `.fr`, vous devez l'acheter. Mais les alternatives gratuites ci-dessus sont parfaites pour commencer !

---

## ✅ Checklist Configuration

- [ ] Choisir un domaine gratuit
- [ ] Créer le fichier `docs/CNAME` avec votre domaine
- [ ] Configurer le DNS (si nécessaire)
- [ ] Push le fichier CNAME sur GitHub
- [ ] Activer GitHub Pages avec le domaine personnalisé
- [ ] Activer HTTPS (après propagation DNS)
- [ ] Tester votre site !

---

## 🆘 Problèmes courants

### DNS ne se propage pas
- Attendez 24-48h pour la propagation DNS
- Vérifiez avec : https://dnschecker.org

### HTTPS grisé
- Attendez que le DNS se propage
- Revenez après quelques heures

### Domaine ne fonctionne pas
- Vérifiez le fichier CNAME
- Vérifiez les enregistrements DNS
- Essayez en navigation privée

---

**Besoin d'aide ?** Demandez-moi ! 🚀
