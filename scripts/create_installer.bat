@echo off
echo ========================================
echo    Création de l'installateur Tempo
echo ========================================

REM Vérifier que Inno Setup est installé
if not exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    echo ERREUR: Inno Setup 6 n'est pas installé
    echo Veuillez télécharger et installer Inno Setup depuis :
    echo https://jrsoftware.org/isinfo.php
    pause
    exit /b 1
)

REM Vérifier que l'application a été construite
if not exist "dist\Tempo\tempo.exe" (
    echo ERREUR: L'application n'a pas été construite
    echo Veuillez d'abord exécuter build_release.bat
    pause
    exit /b 1
)

REM Créer l'installateur
echo Création de l'installateur...
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "scripts\tempo_installer.iss"

REM Vérifier que l'installateur a été créé
if exist "dist\Tempo_Setup_1.0.0.exe" (
    echo.
    echo ========================================
    echo    Installateur créé avec succès !
    echo ========================================
    echo.
    echo Fichier créé : dist\Tempo_Setup_1.0.0.exe
    echo Taille : 
    for %%A in ("dist\Tempo_Setup_1.0.0.exe") do echo %%~zA bytes
    echo.
    echo Vous pouvez maintenant distribuer cet installateur !
    echo.
) else (
    echo ERREUR: La création de l'installateur a échoué
    echo Vérifiez les logs d'Inno Setup
)

pause
