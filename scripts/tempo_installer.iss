; Script d'installation Inno Setup pour Tempo
; Nécessite Inno Setup 6.0+ : https://jrsoftware.org/isinfo.php

#define MyAppName "Tempo"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Votre Entreprise"
#define MyAppURL "https://votre-site.com"
#define MyAppExeName "tempo.exe"

[Setup]
; Informations de base
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
; LicenseFile=LICENSE
OutputDir=dist
OutputBaseFilename=Tempo_Setup_{#MyAppVersion}
; SetupIconFile=lib\features\assets\Tempo.png
Compression=lzma
SolidCompression=yes
WizardStyle=modern

; Permissions
PrivilegesRequired=admin

; Architecture
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "Créer une icône sur le Bureau"; GroupDescription: "Icônes supplémentaires:"
Name: "quicklaunchicon"; Description: "Créer une icône dans la barre de lancement rapide"; GroupDescription: "Icônes supplémentaires:"; Flags: unchecked

[Files]
; Fichiers de l'application
Source: "..\dist\Tempo\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; Note: Ne pas inclure "Source: "..\dist\Tempo\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Lancer {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}\data"
Type: filesandordirs; Name: "{app}\backups"
