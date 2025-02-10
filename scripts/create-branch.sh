#!/bin/bash

# Demande à l'utilisateur de choisir le type de branche
echo "Veuillez choisir un type de branche :"
echo "1) feature"
echo "2) fix"
echo "3) chore"
echo "4) refacto"
read -p "Entrez le numéro correspondant : " TYPE_CHOICE

case $TYPE_CHOICE in
    1) BRANCH_TYPE="feature" ;;
    2) BRANCH_TYPE="fix" ;;
    3) BRANCH_TYPE="chore" ;;
    4) BRANCH_TYPE="refacto" ;;
    *) echo "❌ Erreur : Choix invalide."; exit 1 ;;
esac

# Demande à l'utilisateur d'entrer le nom de la branche
read -p "Entrez le nom de la branche : " BRANCH_NAME

# Vérifie que le nom de branche a été fourni
if [ -z "$BRANCH_NAME" ]; then
    echo "❌ Erreur : Vous devez spécifier un nom de branche !"
    exit 1
fi

FULL_BRANCH_NAME="$BRANCH_TYPE/$BRANCH_NAME"

echo "📌 Vérification de l'existence de la branche develop..."
git fetch origin develop  # Met à jour les infos du repo distant
if ! git show-ref --verify --quiet refs/heads/develop; then
    echo "❌ Erreur : La branche develop n'existe pas en local, récupération depuis GitHub..."
    git checkout -b develop origin/develop
else
    git checkout develop
    git pull origin develop
fi

echo "🚀 Création de la branche $FULL_BRANCH_NAME..."
git checkout -b "$FULL_BRANCH_NAME"

echo "✅ Branche $FULL_BRANCH_NAME créée avec succès !"
echo "📡 Poussée vers GitHub..."
git push -u origin "$FULL_BRANCH_NAME"

echo "🎉 Votre branche $FULL_BRANCH_NAME est prête !"
