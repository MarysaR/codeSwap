#!/bin/bash

# Vérifie si la branche actuelle est une feature
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$CURRENT_BRANCH" != feature/* ]]; then
    echo "❌ Erreur : Vous devez être sur une branche feature/* pour créer une PR."
    echo "💡 Exécutez : git checkout feature/nom-feature"
    exit 1
fi

echo "📌 Vérification de l'existence de la branche develop..."
git fetch origin develop  # Met à jour les infos du repo distant
if ! git show-ref --verify --quiet refs/heads/develop; then
    echo "❌ Erreur : La branche develop n'existe pas en local, récupération depuis GitHub..."
    git checkout -b develop origin/develop
else
    git checkout develop
    git pull origin develop
fi

echo "📡 Poussée de la branche $CURRENT_BRANCH vers GitHub..."
git push origin "$CURRENT_BRANCH"

echo "📝 Création de la Pull Request vers develop en utilisant SSH..."
GIT_SSH_COMMAND="ssh" gh pr create --base develop --head "$CURRENT_BRANCH" --title "PR : ${CURRENT_BRANCH#feature/}" --body "Cette PR ajoute la fonctionnalité ${CURRENT_BRANCH#feature/}"

echo "✅ PR créée avec succès sur GitHub via SSH !"
