# 📱 Tempo - Application de Gestion

Application Flutter complète pour la gestion d'agenda, contacts et articles avec système de sauvegarde avancé.

## ✨ Fonctionnalités

### 📅 **Agenda**
- Gestion des événements avec calendrier
- Vues mensuelle et quotidienne
- Liaison avec contacts et articles
- Rappels et notifications

### 👥 **Contacts**
- Carnet d'adresses avec photos
- Informations complètes (nom, téléphone, email, etc.)
- Liaison avec événements et articles
- Recherche avancée

### 📚 **Articles**
- Articles locaux (PDF, Word, etc.)
- Liens externes (LinkedIn, web, etc.)
- Résumés et tags
- Liaison avec contacts et événements

### 🔍 **Recherche**
- Recherche globale dans toutes les données
- Filtres avancés par type et tags
- Résultats pertinents et triés

### 💾 **Sauvegarde**
- Sauvegarde manuelle et automatique
- Choix libre de l'emplacement
- Format JSON portable
- Restauration complète

## 🏗️ Architecture

- **Framework** : Flutter 3.24+
- **Architecture** : MVVM + Riverpod
- **Base de données** : Drift (SQLite)
- **Navigation** : GoRouter
- **Design** : Material 3

## 🚀 Installation

### Prérequis
- Flutter SDK 3.24+
- Dart 3.0+
- Windows 10/11

### Installation
```bash
# Cloner le dépôt
git clone https://github.com/VOTRE_USERNAME/tempo-app.git
cd tempo-app

# Installer les dépendances
flutter pub get

# Générer la base de données
dart run build_runner build --delete-conflicting-outputs

# Lancer l'application
flutter run -d windows
```

### Build de Production
```bash
# Construire l'application
scripts\build_release.bat

# Créer l'installateur
scripts\create_installer.bat
```

## 📦 Distribution

### Installateur Windows
- Fichier : `scripts\dist\Tempo_Setup_1.0.0.exe`
- Installation automatique
- Icônes sur le bureau
- Désinstallation propre

### Version Portable
- Dossier : `dist\Tempo\`
- Aucune installation requise
- Fonctionne directement

## 🔧 Développement

### Structure du Projet
```
lib/
├── core/                 # Logique métier
│   ├── database/        # Base de données
│   ├── models/          # Modèles de données
│   ├── services/        # Services
│   └── theme/           # Thème de l'application
├── features/            # Fonctionnalités
│   ├── agenda/          # Module agenda
│   ├── contacts/        # Module contacts
│   ├── articles/        # Module articles
│   ├── search/          # Module recherche
│   └── backup/          # Module sauvegarde
└── main.dart           # Point d'entrée
```

### Scripts Utiles
- `scripts\build_release.bat` : Construction de l'application
- `scripts\create_installer.bat` : Création de l'installateur
- `scripts\tempo_installer.iss` : Script Inno Setup

## 🔮 Évolution Future

### Multi-Utilisateurs
- Architecture préparée pour plusieurs utilisateurs
- Isolation des données par utilisateur
- Gestion des rôles et permissions

### Synchronisation Cloud
- Sauvegarde automatique dans le cloud
- Synchronisation entre appareils
- Collaboration en temps réel

## 📄 Licence

MIT License - Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer des améliorations
- Soumettre des pull requests

## 📞 Support

Pour toute question ou problème :
- **Issues** : Utiliser les issues GitHub
- **Documentation** : Voir le fichier [INSTALLATION.md](INSTALLATION.md)

---

**Tempo** - Gestion intelligente de votre temps et de vos données 🚀