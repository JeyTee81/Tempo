@echo off
echo Construction de l'installateur Tempo...

REM Nettoyer les builds précédents
flutter clean

REM Obtenir les dépendances
flutter pub get

REM Construire l'application en mode release
flutter build windows --release

REM Créer le dossier de distribution
if not exist "dist" mkdir dist
if not exist "dist\Tempo" mkdir dist\Tempo

REM Copier les fichiers nécessaires
xcopy "build\windows\x64\runner\Release\*" "dist\Tempo\" /E /I /Y

REM Copier les fichiers de configuration
copy "README.md" "dist\Tempo\"
copy "LICENSE" "dist\Tempo\"

echo.
echo Application construite dans le dossier dist\Tempo\
echo Vous pouvez maintenant créer un installateur avec Inno Setup ou NSIS
echo.
pause
