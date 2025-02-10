#!/bin/bash

# Vérifie si la branche actuelle est une feature, chore, fix ou refacto
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$CURRENT_BRANCH" != feature/* && "$CURRENT_BRANCH" != chore/* && "$CURRENT_BRANCH" != fix/* && "$CURRENT_BRANCH" != refacto/* ]]; then
    echo "❌ Erreur : Vous devez être sur une branche feature/*, chore/*, fix/* ou refacto/* pour créer une PR."
    echo "💡 Exécutez : git checkout feature/nom-feature (ou chore/nom-chore, fix/nom-fix, refacto/nom-refacto)"
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

# Définition du titre et du corps de la PR en fonction du type de branche
BRANCH_TYPE=$(echo "$CURRENT_BRANCH" | cut -d'/' -f1)
BRANCH_NAME=$(echo "$CURRENT_BRANCH" | cut -d'/' -f2)
TITLE="PR : $BRANCH_NAME"
BODY="Cette PR concerne la branche $CURRENT_BRANCH."

echo "📝 Création de la Pull Request vers develop en utilisant SSH..."
GIT_SSH_COMMAND="ssh" gh pr create --base develop --head "$CURRENT_BRANCH" --title "$TITLE" --body "$BODY"

echo "✅ PR créée avec succès sur GitHub via SSH !"
