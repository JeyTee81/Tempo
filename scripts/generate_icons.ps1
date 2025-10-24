# Script PowerShell pour générer les icônes de lancement
Write-Host "🚀 Génération des icônes de lancement Tempo..." -ForegroundColor Blue

# Vérifier que Flutter est installé
try {
    flutter --version | Out-Null
    Write-Host "✅ Flutter détecté" -ForegroundColor Green
} catch {
    Write-Host "❌ Flutter n'est pas installé ou pas dans le PATH" -ForegroundColor Red
    exit 1
}

# Installer les dépendances
Write-Host "📦 Installation des dépendances..." -ForegroundColor Yellow
flutter pub get

# Générer les icônes
Write-Host "🎨 Génération des icônes..." -ForegroundColor Yellow
flutter pub run flutter_launcher_icons:main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Icônes générées avec succès !" -ForegroundColor Green
    Write-Host "📱 Les icônes sont maintenant disponibles pour toutes les plateformes" -ForegroundColor Cyan
} else {
    Write-Host "❌ Erreur lors de la génération des icônes" -ForegroundColor Red
    exit 1
}
