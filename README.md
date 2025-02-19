# Documentation Générale

CodeSwap : Plateforme Collaborative pour Développeurs

# Qu’est-ce que CodeSwap ?

## CodeSwap est une application collaborative permettant aux développeurs de :
- Échanger, tester et évaluer des fragments de code en équipe.
- Obtenir des retours sur leur code en temps réel.
- Travailler sur du code en équipe, avec une logique de code review et de test automatisé.
- Comparer plusieurs implémentations pour trouver la meilleure approche.
  
### L'application repose sur une architecture modulaire avec :
- Frontend (Vue.js) pour une interface moderne et intuitive.
- Backend (Spring Boot) qui gère les utilisateurs, les projets et les requêtes API.
- Logic (Node.js) qui assure le traitement des données et l'exécution de tests.
- Base de données (MySQL) pour stocker les codes et retours.

# À quoi sert CodeSwap ?

Un développeur peut poster un extrait de code et :
- Le tester en temps réel avec différents scénarios.
- Obtenir des feedbacks d’autres développeurs.
- Comparer des solutions alternatives.
- Code Review collaborative

### CodeSwap permet aux équipes de :
- Vérifier la qualité du code avant un merge.
- Ajouter des commentaires et suggestions sur un bout de code précis.
- Visualiser les améliorations proposées avant de les valider.
- Évaluation et notation
- 
### Chaque fragment de code peut être :
- Noté selon son efficacité et sa clarté.
- Comparé avec d’autres implémentations.
- Automatiquement testé avec des entrées/sorties attendues.
- Exécution et vérification de code
  
### Un module d'exécution permet de :
- Tester des exemples concrets de code directement sur la plateforme.
- Lancer des tests unitaires sur le code soumis.
- Vérifier la performance et la compatibilité.
  
## Comment fonctionne CodeSwap ?
Un utilisateur soumet un code en spécifiant son langage.
- Le Backend valide la requête et la stocke en base de données.
- Logic analyse et teste le code (exécution simulée, validation).
- Le Backend récupère le résultat et l’envoie au Frontend.
- Les autres utilisateurs peuvent interagir (commenter, proposer des corrections).

## Pourquoi utiliser CodeSwap ?

- Facilite la collaboration entre développeurs
- Améliore la qualité du code avec des retours en temps réel
- Automatise les tests et l’évaluation des snippets
- Rend l’apprentissage du code plus interactif
---

## 1. Prérequis

Avant de lancer le projet avec Docker, assurez-vous d'avoir :

✅ **Docker installé** : [Télécharger Docker](https://www.docker.com/get-started)  
✅ **Docker Compose installé** (inclus dans Docker Desktop)  
✅ **Git installé** : [Télécharger Git](https://git-scm.com/)

---

## 📥 2. Cloner le projet

Pour récupérer le projet sur votre machine, exécutez :

```bash
git clone https://github.com/VOTRE_UTILISATEUR/CodeSwap.git
cd CodeSwap
```

---

## 3. Lancer le projet

```bash
docker-compose up --build

```

### Vérifier les conteneurs actifs

```bash
docker ps

# Vous devriez voir les conteneurs codeswap-backend-1, codeswap-frontend-1 et codeswap-logic-1 actifs.
```

### Arrêter tous les services

```bash
docker-compose down

```

### Supprimer toutes les images et conteneurs

```bash
docker system prune -a

```

## 4. Accès aux Services

    Backend (Spring Boot)	http://localhost:8080/
    Frontend (Vue.js)	http://localhost:5173/

## 5. Résumé

    ✅ Cloner le projet avec git clone
    ✅ Lancer les services avec docker-compose up --build
    ✅ Accéder au backend (http://localhost:8080/) et frontend (http://localhost:5173/)
    ✅ Suivre les bonnes pratiques Git et Docker
