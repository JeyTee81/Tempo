import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/router/app_router.dart';
import 'package:tempo/core/theme/app_theme.dart';
import 'package:tempo/core/services/auto_backup_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize French locale data
  await initializeDateFormatting('fr_FR', null);

  // Initialize database
  final database = AppDatabase();
  await database.init();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const TempoApp(),
    ),
  );
}

class TempoApp extends ConsumerWidget {
  const TempoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Tempo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
