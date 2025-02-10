# 🐳 Documentation Docker - CodeSwap

Ce document explique comment utiliser Docker pour orchestrer les services **Backend (Spring Boot)**, **Frontend (Vue.js)** et **Logic (TypeScript/Jest)** dans le projet **CodeSwap**.

---

## 1. Prérequis

Avant de lancer le projet avec Docker, assurez-vous d'avoir :

✅ **Docker installé** : [Télécharger Docker](https://www.docker.com/get-started)  
✅ **Docker Compose installé** (inclus dans Docker Desktop)  
✅ **Git installé** : [Télécharger Git](https://git-scm.com/)

---

## 2. Architecture des services Docker

### **Services et Ports**

| Service      | Technologie     | Port Exposé | Description                   |
| ------------ | --------------- | ----------- | ----------------------------- |
| **Backend**  | Spring Boot     | `8080`      | API REST du projet            |
| **Frontend** | Vue.js (Vite)   | `5173`      | Interface utilisateur         |
| **Logic**    | TypeScript/Jest | -           | Cœur métier (tests unitaires) |

---

## 3. Configuration des Services

### **Backend (Spring Boot)**

**Fichier** : `backend/Dockerfile`

```dockerfile
FROM openjdk:17-alpine

# Installer Maven
RUN apk update && apk add --no-cache maven

WORKDIR /app

# Copier pom.xml et télécharger les dépendances
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copier le projet et compiler
COPY . .
RUN mvn clean package

EXPOSE 8080
CMD ["java", "-jar", "/app/target/backend-1.0-SNAPSHOT.jar"]

#  Démarre un serveur (logique serveur) Spring Boot sur http://localhost:8080/

```

### **logic (TypeScript/Jest)**

**Fichier** : `logic/Dockerfile`

```dockerfile
FROM node:16

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

CMD ["npm", "test"]

# Exécute les tests Jest de la logique métier.

```

### **frontend (Vue.js)**

**Fichier** : `frontend/Dockerfile`

```dockerfile
FROM node:16

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

CMD ["npm", "test"]

# Démarre le frontend Vue.js sur  http://localhost:5173/

```

---

## 4. Docker Compose - Orchestration des Services

**Fichier** : `docker-compose.yml`

```bash
version: "3.8"

services:
  backend:
    build: ./backend
    ports:
      - "8080:8080"
    depends_on:
      - logic

  logic:
    build: ./logic

  frontend:
    build: ./frontend
    ports:
      - "5173:5173"
    depends_on:
      - backend

#  Orchestre les services pour qu'ils communiquent entre eux.

```

## 5. Lancer le projet

```bash
docker-compose up --build

```

### Vérifier les conteneurs actifs

```bash
docker ps
```

### Arrêter tous les services

```bash
docker-compose down

```

### Supprimer toutes les images et conteneurs

```bash
docker system prune -a

```

## 6. Accès aux Services

    Backend (Spring Boot)	http://localhost:8080/
    Frontend (Vue.js)	http://localhost:5173/

## 7. Bonnes Pratiques Docker

    - Toujours exécuter docker-compose up --build après un changement de configuration.
    - Ne jamais commit node_modules/ ou target/ dans Git.
    - Utiliser docker logs [nom_du_conteneur] pour voir les logs en cas de problème.
