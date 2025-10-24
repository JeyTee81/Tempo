import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/services/user_service.dart';
import 'package:tempo/core/models/user.dart';
import 'package:tempo/core/models/contact.dart';
import 'package:tempo/core/models/article.dart';
import 'package:tempo/core/models/event.dart';
import 'package:intl/intl.dart';

/// Service pour la sauvegarde et restauration des données
class BackupService {
  final AppDatabase _database;
  final UserService _userService;

  BackupService(this._database, this._userService);

  /// Créer une sauvegarde complète
  Future<BackupData> createBackup() async {
    final users = await _database.select(_database.users).get();
    final contacts = await _database.select(_database.contacts).get();
    final articles = await _database.select(_database.articles).get();
    final events = await _database.select(_database.events).get();
    final eventContacts = await _database.select(_database.eventContacts).get();
    final eventArticles = await _database.select(_database.eventArticles).get();

    return BackupData(
      version: '1.0',
      createdAt: DateTime.now(),
      users: users,
      contacts: contacts,
      articles: articles,
      events: events,
      eventContacts: eventContacts,
      eventArticles: eventArticles,
    );
  }

  /// Sauvegarder dans un fichier JSON avec choix d'emplacement
  Future<File> saveBackupToFile(
      {String? customName, String? customPath}) async {
    final backup = await createBackup();

    File file;
    if (customPath != null) {
      // Utiliser le chemin personnalisé
      file = File(customPath);
    } else {
      // Utiliser le dossier par défaut
      final directory = await getApplicationDocumentsDirectory();
      final backupDir = Directory('${directory.path}/backups');

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(backup.createdAt);
      final fileName = customName ?? 'tempo_backup_$timestamp.json';
      file = File('${backupDir.path}/$fileName');
    }

    final jsonData = backup.toJson();
    await file.writeAsString(jsonEncode(jsonData));

    return file;
  }

  /// Sauvegarder avec sélection d'emplacement par l'utilisateur
  Future<File?> saveBackupWithLocationPicker({String? customName}) async {
    try {
      // Demander à l'utilisateur de choisir l'emplacement
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Choisir l\'emplacement de sauvegarde',
        fileName: customName ??
            'tempo_backup_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        return await saveBackupToFile(
            customName: customName, customPath: result);
      }

      return null;
    } catch (e) {
      throw Exception('Erreur lors de la sélection de l\'emplacement: $e');
    }
  }

  /// Restaurer depuis un fichier JSON
  Future<void> restoreFromFile(File backupFile) async {
    final jsonString = await backupFile.readAsString();
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final backup = BackupData.fromJson(jsonData);

    await _restoreBackup(backup);
  }

  /// Restaurer avec sélection de fichier par l'utilisateur
  Future<void> restoreWithFilePicker() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
        dialogTitle: 'Choisir le fichier de sauvegarde à restaurer',
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        await restoreFromFile(file);
      }
    } catch (e) {
      throw Exception('Erreur lors de la sélection du fichier: $e');
    }
  }

  /// Restaurer les données de sauvegarde
  Future<void> _restoreBackup(BackupData backup) async {
    // Vider les tables existantes
    await _database.delete(_database.eventArticles).go();
    await _database.delete(_database.eventContacts).go();
    await _database.delete(_database.events).go();
    await _database.delete(_database.articles).go();
    await _database.delete(_database.contacts).go();
    await _database.delete(_database.users).go();

    // Restaurer les utilisateurs
    for (final user in backup.users) {
      await _database.into(_database.users).insertReturning(user);
    }

    // Restaurer les contacts
    for (final contact in backup.contacts) {
      await _database.into(_database.contacts).insertReturning(contact);
    }

    // Restaurer les articles
    for (final article in backup.articles) {
      await _database.into(_database.articles).insertReturning(article);
    }

    // Restaurer les événements
    for (final event in backup.events) {
      await _database.into(_database.events).insertReturning(event);
    }

    // Restaurer les relations
    for (final eventContact in backup.eventContacts) {
      await _database
          .into(_database.eventContacts)
          .insertReturning(eventContact);
    }

    for (final eventArticle in backup.eventArticles) {
      await _database
          .into(_database.eventArticles)
          .insertReturning(eventArticle);
    }
  }

  /// Obtenir la liste des sauvegardes disponibles
  Future<List<BackupFileInfo>> getAvailableBackups() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backups');

    if (!await backupDir.exists()) {
      return [];
    }

    final files = await backupDir.list().toList();
    final backupFiles = <BackupFileInfo>[];

    for (final file in files) {
      if (file is File && file.path.endsWith('.json')) {
        try {
          final stat = await file.stat();
          final jsonString = await file.readAsString();
          final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
          final backup = BackupData.fromJson(jsonData);

          backupFiles.add(BackupFileInfo(
            file: file,
            name: file.path.split('/').last,
            size: stat.size,
            createdAt: backup.createdAt,
            userCount: backup.users.length,
            contactCount: backup.contacts.length,
            articleCount: backup.articles.length,
            eventCount: backup.events.length,
          ));
        } catch (e) {
          // Ignorer les fichiers corrompus
          continue;
        }
      }
    }

    // Trier par date de création (plus récent en premier)
    backupFiles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return backupFiles;
  }

  /// Supprimer une sauvegarde
  Future<void> deleteBackup(File backupFile) async {
    if (await backupFile.exists()) {
      await backupFile.delete();
    }
  }

  /// Obtenir les statistiques de sauvegarde
  Future<BackupStats> getBackupStats() async {
    final users = await _database.select(_database.users).get();
    final contacts = await _database.select(_database.contacts).get();
    final articles = await _database.select(_database.articles).get();
    final events = await _database.select(_database.events).get();

    return BackupStats(
      userCount: users.length,
      contactCount: contacts.length,
      articleCount: articles.length,
      eventCount: events.length,
      totalSize: await _calculateDatabaseSize(),
    );
  }

  /// Calculer la taille de la base de données
  Future<int> _calculateDatabaseSize() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbFile = File('${directory.path}/tempo.db');

    if (await dbFile.exists()) {
      final stat = await dbFile.stat();
      return stat.size;
    }

    return 0;
  }
}

/// Modèle de données de sauvegarde
class BackupData {
  final String version;
  final DateTime createdAt;
  final List<User> users;
  final List<Contact> contacts;
  final List<Article> articles;
  final List<Event> events;
  final List<EventContact> eventContacts;
  final List<EventArticle> eventArticles;

  BackupData({
    required this.version,
    required this.createdAt,
    required this.users,
    required this.contacts,
    required this.articles,
    required this.events,
    required this.eventContacts,
    required this.eventArticles,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'createdAt': createdAt.toIso8601String(),
      'users': users.map((u) => u.toJson()).toList(),
      'contacts': contacts.map((c) => c.toJson()).toList(),
      'articles': articles.map((a) => a.toJson()).toList(),
      'events': events.map((e) => e.toJson()).toList(),
      'eventContacts': eventContacts.map((ec) => ec.toJson()).toList(),
      'eventArticles': eventArticles.map((ea) => ea.toJson()).toList(),
    };
  }

  factory BackupData.fromJson(Map<String, dynamic> json) {
    return BackupData(
      version: json['version'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      users: (json['users'] as List).map((u) => User.fromJson(u)).toList(),
      contacts:
          (json['contacts'] as List).map((c) => Contact.fromJson(c)).toList(),
      articles:
          (json['articles'] as List).map((a) => Article.fromJson(a)).toList(),
      events: (json['events'] as List).map((e) => Event.fromJson(e)).toList(),
      eventContacts: (json['eventContacts'] as List)
          .map((ec) => EventContact.fromJson(ec))
          .toList(),
      eventArticles: (json['eventArticles'] as List)
          .map((ea) => EventArticle.fromJson(ea))
          .toList(),
    );
  }
}

/// Informations sur un fichier de sauvegarde
class BackupFileInfo {
  final File file;
  final String name;
  final int size;
  final DateTime createdAt;
  final int userCount;
  final int contactCount;
  final int articleCount;
  final int eventCount;

  BackupFileInfo({
    required this.file,
    required this.name,
    required this.size,
    required this.createdAt,
    required this.userCount,
    required this.contactCount,
    required this.articleCount,
    required this.eventCount,
  });

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get formattedDate {
    return DateFormat('dd/MM/yyyy à HH:mm').format(createdAt);
  }
}

/// Statistiques de sauvegarde
class BackupStats {
  final int userCount;
  final int contactCount;
  final int articleCount;
  final int eventCount;
  final int totalSize;

  BackupStats({
    required this.userCount,
    required this.contactCount,
    required this.articleCount,
    required this.eventCount,
    required this.totalSize,
  });

  String get formattedTotalSize {
    if (totalSize < 1024) return '$totalSize B';
    if (totalSize < 1024 * 1024)
      return '${(totalSize / 1024).toStringAsFixed(1)} KB';
    return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Provider pour le service de sauvegarde
final backupServiceProvider = Provider<BackupService>((ref) {
  final database = ref.watch(databaseProvider);
  final userService = ref.watch(userServiceProvider);
  return BackupService(database, userService);
});
