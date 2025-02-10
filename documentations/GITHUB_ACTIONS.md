# 🚀 Documentation GitHub Actions pour CodeSwap

Ce document explique en détail **les workflows GitHub Actions** mis en place pour **automatiser le contrôle des branches, des Pull Requests et du CI/CD** dans CodeSwap.

---

## 1. Workflow `restrict-branches.yml`

**Description**  
Ce workflow **empêche la création de branches qui ne respectent pas la convention de nommage**.  
Seules les branches **`feature/`, `fix/`, `chore/` et `refacto/`** sont autorisées.

**Déclenchement (`on:`)**

```yaml
on:
  create:
    tags-ignore:
      - "**"
    branches:
      - "**"

#### Vérification appliquée
if [[ ! "$BRANCH_NAME" =~ ^(feature|fix|chore|refacto)/ ]]; then
    echo "❌ Erreur : Le nom de la branche doit commencer par 'feature/', 'fix/', 'chore/' ou 'refacto/'."
    exit 1
fi
```

### Cela va :

- Bloquer toute branche qui ne suit pas la convention.
- Autoriser uniquement `feature/`, `fix/`, `chore/` et `refacto/`.
- Protéger le workflow contre les tags Git (tags-ignore).

## 2. Workflow `restrict-prs.yml`

**Description**

Ce workflow **empêche la création de PRs vers develop** si elles ne viennent pas d’une branche correcte `feature/, fix/, chore/, refacto/`.

**Déclenchement (`on:`)**

```yaml
on:
  pull_request:
    branches:
      - develop

#### Vérification appliquée
if [[ ! "$BRANCH_NAME" =~ ^(feature|chore|fix|refacto)/ ]]; then
    echo "❌ Erreur : Seules les branches 'feature/', 'chore/', 'fix/', et 'refacto/' peuvent ouvrir une PR vers 'develop'."
    exit 1
fi
```

### Cela va :

- Bloquer les PRs venant de `hotfix/`, `test/`, ou tout autre préfixe interdit.
- Autoriser uniquement `feature/`, `fix/`, `chore/` et `refacto/`.

## 3. Workflow `ci-cd.yml`

**Description**

Ce workflow **gère le pipeline CI/CD pour valider les PRs** avant qu'elles ne soient fusionnées.

**Déclenchement (`on:`)**

```yaml
on:
  pull_request:
    branches:
      - develop
      - main

#### Exécution des tests
steps:
  - name: Checkout du code
    uses: actions/checkout@v3

  - name: Vérification de la structure du projet
    run: ls -R
```

### Cela va :

- Vérifier que GitHub récupère bien tous les fichiers du repo.
- Supprimer `npm install` car on ne l’utilise pas encore.
- Servir de base pour ajouter des tests unitaires dans le futur.

#### Trois workflows GitHub Actions pour :

- Restreindre les branches,
- Les PRs
- Gérer CI/CD
