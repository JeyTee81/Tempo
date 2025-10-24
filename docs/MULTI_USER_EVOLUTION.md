# Évolution Multi-Utilisateurs - Tempo

## 🎯 Objectif

Préparer l'architecture de l'application Tempo pour supporter plusieurs utilisateurs à l'avenir, tout en gardant la simplicité actuelle mono-utilisateur.

## 🏗️ Architecture Actuelle vs Future

### État Actuel (Mono-utilisateur)
- **Utilisateur unique** : Une secrétaire gère les données d'une personne
- **Données partagées** : Tous les contacts, événements, articles sont visibles
- **Simplicité** : Pas de gestion de comptes ou de permissions

### État Future (Multi-utilisateurs)
- **Plusieurs utilisateurs** : Chaque personne a son propre espace
- **Données isolées** : Chaque utilisateur voit uniquement ses données
- **Gestion des rôles** : Admin, utilisateur, secrétaire
- **Partage optionnel** : Possibilité de partager des éléments entre utilisateurs

## 📊 Modifications de la Base de Données

### Table Users (Nouvelle)
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  firstName TEXT NOT NULL,
  lastName TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  photoUrl TEXT,
  role TEXT DEFAULT 'user',
  isActive BOOLEAN DEFAULT true,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  lastLoginAt DATETIME
);
```

### Tables Modifiées
Toutes les tables principales ont maintenant un champ `userId` :
- `contacts.userId` → Référence vers `users.id`
- `articles.userId` → Référence vers `users.id`
- `events.userId` → Référence vers `users.id`

## 🔧 Services Préparés

### UserService
- `createDefaultUser()` : Créer l'utilisateur par défaut
- `getCurrentUser()` : Obtenir l'utilisateur actuel
- `hasUsers()` : Vérifier l'existence d'utilisateurs

### UserContextService
- `getCurrentUserId()` : ID de l'utilisateur actuel
- `getContactsForCurrentUser()` : Contacts filtrés par utilisateur
- `getArticlesForCurrentUser()` : Articles filtrés par utilisateur
- `getEventsForCurrentUser()` : Événements filtrés par utilisateur

## 🚀 Migration Future

### Phase 1 : Préparation (Actuelle)
- ✅ Tables avec `userId` nullable
- ✅ Services de gestion des utilisateurs
- ✅ Architecture prête pour l'évolution

### Phase 2 : Authentification
- [ ] Système de connexion/déconnexion
- [ ] Gestion des sessions
- [ ] Interface de sélection d'utilisateur

### Phase 3 : Isolation des Données
- [ ] Filtrage automatique par `userId`
- [ ] Migration des données existantes
- [ ] Interface multi-utilisateurs

### Phase 4 : Fonctionnalités Avancées
- [ ] Partage d'éléments entre utilisateurs
- [ ] Rôles et permissions
- [ ] Synchronisation cloud

## 📱 Interface Utilisateur Future

### Écran de Sélection d'Utilisateur
```dart
class UserSelectionPage extends StatelessWidget {
  // Liste des utilisateurs disponibles
  // Bouton "Nouvel utilisateur"
  // Sélection de l'utilisateur actuel
}
```

### Gestion des Profils
```dart
class UserProfilePage extends StatelessWidget {
  // Informations de l'utilisateur
  // Photo de profil
  // Paramètres de compte
}
```

## 🔄 Migration des Données

### Script de Migration
```sql
-- Ajouter l'utilisateur par défaut
INSERT INTO users (firstName, lastName, email, role) 
VALUES ('Utilisateur', 'Principal', 'user@tempo.app', 'admin');

-- Associer les données existantes à l'utilisateur par défaut
UPDATE contacts SET userId = 1 WHERE userId IS NULL;
UPDATE articles SET userId = 1 WHERE userId IS NULL;
UPDATE events SET userId = 1 WHERE userId IS NULL;
```

## 🎯 Avantages de cette Approche

### Pour l'Utilisateur Actuel
- **Aucun changement** : L'application fonctionne exactement pareil
- **Données préservées** : Toutes les données existantes sont conservées
- **Évolution transparente** : Passage progressif au multi-utilisateurs

### Pour le Développement Futur
- **Architecture prête** : Pas de refactoring majeur nécessaire
- **Évolutivité** : Ajout facile de nouvelles fonctionnalités
- **Flexibilité** : Support de différents scénarios d'usage

## 📋 Checklist d'Évolution

### Immédiat (Actuel)
- [x] Tables avec `userId` nullable
- [x] Services de base créés
- [x] Architecture préparée

### Court Terme
- [ ] Interface de sélection d'utilisateur
- [ ] Migration des données existantes
- [ ] Tests de l'isolation des données

### Moyen Terme
- [ ] Système d'authentification
- [ ] Gestion des rôles
- [ ] Interface de gestion des utilisateurs

### Long Terme
- [ ] Partage d'éléments
- [ ] Synchronisation cloud
- [ ] Fonctionnalités collaboratives

## 🔧 Commandes de Migration

```bash
# Régénérer la base de données avec les nouvelles tables
flutter packages pub run build_runner build --delete-conflicting-outputs

# Lancer l'application (création automatique de l'utilisateur par défaut)
flutter run
```

## 📝 Notes Importantes

1. **Rétrocompatibilité** : L'application actuelle continue de fonctionner
2. **Migration automatique** : L'utilisateur par défaut est créé automatiquement
3. **Évolution progressive** : Chaque phase peut être implémentée indépendamment
4. **Données préservées** : Aucune perte de données lors de l'évolution

Cette architecture permet une évolution en douceur de l'application mono-utilisateur vers une solution multi-utilisateurs complète.
