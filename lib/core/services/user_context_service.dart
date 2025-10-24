import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/services/user_service.dart';

/// Service pour gérer le contexte utilisateur (préparation pour multi-utilisateurs)
class UserContextService {
  final AppDatabase _database;
  final UserService _userService;

  UserContextService(this._database, this._userService);

  /// Obtenir l'ID de l'utilisateur actuel
  Future<int?> getCurrentUserId() async {
    final user = await _userService.getCurrentUser();
    return user?.id;
  }

  /// Filtrer les contacts par utilisateur (pour l'instant, tous les contacts)
  Future<List<Contact>> getContactsForCurrentUser() async {
    // Pour l'instant, retourner tous les contacts
    // Dans le futur, filtrer par userId
    return await _database.select(_database.contacts).get();
  }

  /// Filtrer les articles par utilisateur (pour l'instant, tous les articles)
  Future<List<Article>> getArticlesForCurrentUser() async {
    // Pour l'instant, retourner tous les articles
    // Dans le futur, filtrer par userId
    return await _database.select(_database.articles).get();
  }

  /// Filtrer les événements par utilisateur (pour l'instant, tous les événements)
  Future<List<Event>> getEventsForCurrentUser() async {
    // Pour l'instant, retourner tous les événements
    // Dans le futur, filtrer par userId
    return await _database.select(_database.events).get();
  }

  /// Créer un contact pour l'utilisateur actuel
  Future<Contact> createContactForCurrentUser(ContactsCompanion contact) async {
    final userId = await getCurrentUserId();
    final contactWithUser = contact.copyWith(
      userId: drift.Value(userId),
    );
    return await _database
        .into(_database.contacts)
        .insertReturning(contactWithUser);
  }

  /// Créer un article pour l'utilisateur actuel
  Future<Article> createArticleForCurrentUser(ArticlesCompanion article) async {
    final userId = await getCurrentUserId();
    final articleWithUser = article.copyWith(
      userId: drift.Value(userId),
    );
    return await _database
        .into(_database.articles)
        .insertReturning(articleWithUser);
  }

  /// Créer un événement pour l'utilisateur actuel
  Future<Event> createEventForCurrentUser(EventsCompanion event) async {
    final userId = await getCurrentUserId();
    final eventWithUser = event.copyWith(
      userId: drift.Value(userId),
    );
    return await _database
        .into(_database.events)
        .insertReturning(eventWithUser);
  }
}

/// Provider pour le service de contexte utilisateur
final userContextServiceProvider = Provider<UserContextService>((ref) {
  final database = ref.watch(databaseProvider);
  final userService = ref.watch(userServiceProvider);
  return UserContextService(database, userService);
});
