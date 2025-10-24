@echo off
echo ========================================
echo    Construction de Tempo - Version Release
echo ========================================

REM Vérifier que Flutter est installé
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ERREUR: Flutter n'est pas installé ou pas dans le PATH
    echo Veuillez installer Flutter depuis https://flutter.dev
    pause
    exit /b 1
)

REM Nettoyer les builds précédents
echo Nettoyage des builds précédents...
flutter clean

REM Obtenir les dépendances
echo Récupération des dépendances...
flutter pub get

REM Générer les fichiers de base de données
echo Génération des fichiers de base de données...
dart run build_runner build --delete-conflicting-outputs

REM Construire l'application en mode release
echo Construction de l'application (mode release)...
flutter build windows --release

REM Vérifier que la construction a réussi
if not exist "build\windows\x64\runner\Release\tempo.exe" (
    echo ERREUR: La construction a échoué
    pause
    exit /b 1
)

REM Créer le dossier de distribution
echo Création du dossier de distribution...
if exist "dist" rmdir /s /q "dist"
mkdir "dist"
mkdir "dist\Tempo"

REM Copier les fichiers de l'application
echo Copie des fichiers de l'application...
xcopy "build\windows\x64\runner\Release\*" "dist\Tempo\" /E /I /Y

REM Copier les fichiers de documentation
echo Copie des fichiers de documentation...
if exist "README.md" copy "README.md" "dist\Tempo\"
if exist "INSTALLATION.md" copy "INSTALLATION.md" "dist\Tempo\"
if exist "LICENSE" copy "LICENSE" "dist\Tempo\"

REM Créer un fichier de version
echo Création du fichier de version...
echo Tempo v1.0.0 > "dist\Tempo\version.txt"
echo Build: %date% %time% >> "dist\Tempo\version.txt"

REM Créer un script de lancement
echo Création du script de lancement...
echo @echo off > "dist\Tempo\Lancer Tempo.bat"
echo cd /d "%%~dp0" >> "dist\Tempo\Lancer Tempo.bat"
echo tempo.exe >> "dist\Tempo\Lancer Tempo.bat"

echo.
echo ========================================
echo    Construction terminée avec succès !
echo ========================================
echo.
echo Fichiers créés :
echo - dist\Tempo\ : Application portable
echo - dist\Tempo\Lancer Tempo.bat : Script de lancement
echo.
echo Prochaines étapes :
echo 1. Tester l'application : dist\Tempo\tempo.exe
echo 2. Créer un installateur avec Inno Setup
echo 3. Distribuer aux utilisateurs
echo.
pause
