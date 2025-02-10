# 🚀 Scripts Bash pour Automatiser le Workflow GitHub

Ce document explique l'utilisation des **scripts Bash** pour automatiser la gestion des branches et des Pull Requests dans le projet **CodeSwap**.

---

## 1. Script `create-feature.sh`

**Description**

Ce script permet de **créer une nouvelle branche `feature/xxx` à partir de `develop`** et de la pousser sur GitHub automatiquement.

**Utilisation**

1️. **Rendre le script exécutable (une seule fois)**

```bash
chmod +x create-feature.sh
```

2. **Exécuter le script**

```bash
./create-feature.sh nom-de-la-fonctionnalité
```

### Cela va :

- Vérifier et mettre à jour `develop`
- Créer une branche `feature/nom-de-la-fonctionnalité`
- Pousser la branche sur GitHub

### Ce que fais le script :

- Vérifie que `develop` existe et est à jour.
- Crée la branche `feature/ajout-authentification` à partir de `develop`.
- Pousse cette branche sur GitHub.

---

## 2. Script `create-pr.sh`

**Description**

Ce script permet de **créer une Pull Request (PR) automatiquement** depuis `une branche feature/xxx vers develop`, en utilisant SSH.

**Utilisation**

1️. **Rendre le script exécutable (une seule fois)**

```bash
chmod +x create-pr.sh
```

2. **Exécuter le script**

```bash
./create-pr.sh
```

### Cela va :

- Vérifier que `develop` est bien à jour.
- Pousser la branche `feature/xxx` sur GitHub.
- Créer une Pull Request automatique vers `develop`.

### Exemple d'exécution :

```bash
git checkout feature/ajout-authentification

./create-pr.sh

```

### Ce que fais le script :

- Vérifie que `develop` est bien à jour.
- Pousse la branche `feature/ajout-authentification` sur GitHub.
- Crée une PR automatique vers `develop`.

---
