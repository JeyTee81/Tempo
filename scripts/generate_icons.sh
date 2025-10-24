#!/bin/bash

# Script bash pour générer les icônes de lancement
echo "🚀 Génération des icônes de lancement Tempo..."

# Vérifier que Flutter est installé
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter n'est pas installé ou pas dans le PATH"
    exit 1
fi

echo "✅ Flutter détecté"

# Installer les dépendances
echo "📦 Installation des dépendances..."
flutter pub get

# Générer les icônes
echo "🎨 Génération des icônes..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Icônes générées avec succès !"
    echo "📱 Les icônes sont maintenant disponibles pour toutes les plateformes"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi
