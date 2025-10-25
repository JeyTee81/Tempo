import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempo/core/database/tables.dart';
import 'package:tempo/core/database/daos.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Contacts,
    Articles,
    Events,
    EventContacts,
    EventArticles,
    ArticleContacts
  ],
  daos: [ContactDao, ArticleDao, EventDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
      );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'tempo.db'));
      return NativeDatabase(file);
    });
  }

  Future<void> init() async {
    // Database is automatically initialized by Drift
  }
}

// Provider for Riverpod
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError();
});
