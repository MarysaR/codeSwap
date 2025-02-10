#!/bin/bash

# Vérifie si un nom de branche a été fourni
if [ -z "$1" ]; then
    echo "❌ Erreur : Vous devez spécifier un nom de fonctionnalité !"
    echo "Usage : ./create-feature.sh nom-de-la-fonctionnalité"
    exit 1
fi

FEATURE_NAME="feature/$1"

echo "📌 Vérification de l'existence de la branche develop..."
git fetch origin develop  # Met à jour les infos du repo distant
if ! git show-ref --verify --quiet refs/heads/develop; then
    echo "❌ Erreur : La branche develop n'existe pas en local, récupération depuis GitHub..."
    git checkout -b develop origin/develop
else
    git checkout develop
    git pull origin develop
fi

echo "🚀 Création de la branche $FEATURE_NAME..."
git checkout -b "$FEATURE_NAME"

echo "✅ Branche $FEATURE_NAME créée avec succès !"
echo "📡 Poussée vers GitHub..."
git push -u origin "$FEATURE_NAME"

echo "🎉 Votre branche $FEATURE_NAME est prête !"

