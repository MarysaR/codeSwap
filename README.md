# 🐳 Documentation Générale - CodeSwap

Bienvenue sur **CodeSwap**, un projet intégrant **Backend (Spring Boot)**, **Frontend (Vue.js)** et **Logic (TypeScript/Jest)**, entièrement conteneurisé avec **Docker**.

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
