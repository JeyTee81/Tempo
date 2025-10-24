import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempo/core/database/database.dart';
import 'package:drift/drift.dart' as drift;

/// Service pour la gestion des utilisateurs (préparation pour multi-utilisateurs)
class UserService {
  final AppDatabase _database;

  UserService(this._database);

  /// Créer un utilisateur par défaut (pour la version actuelle mono-utilisateur)
  Future<User> createDefaultUser() async {
    final defaultUser = UsersCompanion(
      firstName: drift.Value('Utilisateur'),
      lastName: drift.Value('Principal'),
      email: drift.Value('user@tempo.app'),
      role: drift.Value('admin'),
      isActive: drift.Value(true),
    );

    return await _database.into(_database.users).insertReturning(defaultUser);
  }

  /// Obtenir l'utilisateur actuel (pour l'instant, le premier utilisateur)
  Future<User?> getCurrentUser() async {
    final users = await _database.select(_database.users).get();
    return users.isNotEmpty ? users.first : null;
  }

  /// Vérifier si des utilisateurs existent
  Future<bool> hasUsers() async {
    final users = await _database.select(_database.users).get();
    return users.isNotEmpty;
  }

  /// Initialiser l'utilisateur par défaut si nécessaire
  Future<User> ensureDefaultUser() async {
    if (!await hasUsers()) {
      return await createDefaultUser();
    }
    return await getCurrentUser() ?? await createDefaultUser();
  }
}

/// Provider pour le service utilisateur
final userServiceProvider = Provider<UserService>((ref) {
  final database = ref.watch(databaseProvider);
  return UserService(database);
});

/// Provider pour l'utilisateur actuel
final currentUserProvider = FutureProvider<User?>((ref) async {
  final userService = ref.watch(userServiceProvider);
  return await userService.getCurrentUser();
});
