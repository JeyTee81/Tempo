import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempo/core/services/backup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

/// Service de sauvegarde automatique
class AutoBackupService {
  final BackupService _backupService;
  Timer? _backupTimer;
  static const String _lastBackupKey = 'last_auto_backup';
  static const String _autoBackupEnabledKey = 'auto_backup_enabled';
  static const String _backupIntervalKey = 'backup_interval_hours';

  AutoBackupService(this._backupService);

  /// Démarrer la sauvegarde automatique
  Future<void> startAutoBackup() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_autoBackupEnabledKey) ?? true;

    if (!isEnabled) return;

    final intervalHours = prefs.getInt(_backupIntervalKey) ?? 24;
    final interval = Duration(hours: intervalHours);

    _backupTimer?.cancel();
    _backupTimer = Timer.periodic(interval, (timer) async {
      await _performAutoBackup();
    });
  }

  /// Arrêter la sauvegarde automatique
  void stopAutoBackup() {
    _backupTimer?.cancel();
    _backupTimer = null;
  }

  /// Effectuer une sauvegarde automatique
  Future<void> _performAutoBackup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastBackup = prefs.getString(_lastBackupKey);

      if (lastBackup != null) {
        final lastBackupDate = DateTime.parse(lastBackup);
        final now = DateTime.now();

        // Vérifier si une sauvegarde a déjà été faite aujourd'hui
        if (lastBackupDate.day == now.day &&
            lastBackupDate.month == now.month &&
            lastBackupDate.year == now.year) {
          return; // Sauvegarde déjà faite aujourd'hui
        }
      }

      // Créer la sauvegarde automatique
      await _backupService.saveBackupToFile(
        customName: 'auto_backup_${DateTime.now().millisecondsSinceEpoch}.json',
      );

      // Mettre à jour la date de dernière sauvegarde
      await prefs.setString(_lastBackupKey, DateTime.now().toIso8601String());
    } catch (e) {
      // En cas d'erreur, on ne fait rien pour éviter les boucles
      print('Erreur lors de la sauvegarde automatique: $e');
    }
  }

  /// Activer/désactiver la sauvegarde automatique
  Future<void> setAutoBackupEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoBackupEnabledKey, enabled);

    if (enabled) {
      await startAutoBackup();
    } else {
      stopAutoBackup();
    }
  }

  /// Définir l'intervalle de sauvegarde automatique
  Future<void> setBackupInterval(int hours) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backupIntervalKey, hours);

    // Redémarrer le timer avec le nouvel intervalle
    await startAutoBackup();
  }

  /// Obtenir les paramètres de sauvegarde automatique
  Future<AutoBackupSettings> getAutoBackupSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AutoBackupSettings(
      isEnabled: prefs.getBool(_autoBackupEnabledKey) ?? true,
      intervalHours: prefs.getInt(_backupIntervalKey) ?? 24,
      lastBackup: prefs.getString(_lastBackupKey),
    );
  }

  /// Forcer une sauvegarde maintenant
  Future<void> forceBackupNow() async {
    await _performAutoBackup();
  }

  /// Nettoyer les anciennes sauvegardes automatiques (garder seulement les 10 dernières)
  Future<void> cleanupOldBackups() async {
    try {
      final backups = await _backupService.getAvailableBackups();
      final autoBackups = backups
          .where((backup) => backup.name.startsWith('auto_backup_'))
          .toList();

      if (autoBackups.length > 10) {
        // Trier par date de création (plus ancien en premier)
        autoBackups.sort((a, b) => a.createdAt.compareTo(b.createdAt));

        // Supprimer les anciennes sauvegardes
        final toDelete = autoBackups.take(autoBackups.length - 10);
        for (final backup in toDelete) {
          await _backupService.deleteBackup(backup.file);
        }
      }
    } catch (e) {
      print('Erreur lors du nettoyage des sauvegardes: $e');
    }
  }
}

/// Paramètres de sauvegarde automatique
class AutoBackupSettings {
  final bool isEnabled;
  final int intervalHours;
  final String? lastBackup;

  AutoBackupSettings({
    required this.isEnabled,
    required this.intervalHours,
    this.lastBackup,
  });

  DateTime? get lastBackupDate {
    if (lastBackup == null) return null;
    try {
      return DateTime.parse(lastBackup!);
    } catch (e) {
      return null;
    }
  }
}

/// Provider pour le service de sauvegarde automatique
final autoBackupServiceProvider = Provider<AutoBackupService>((ref) {
  final backupService = ref.watch(backupServiceProvider);
  return AutoBackupService(backupService);
});

/// Provider pour les paramètres de sauvegarde automatique
final autoBackupSettingsProvider =
    FutureProvider<AutoBackupSettings>((ref) async {
  final autoBackupService = ref.watch(autoBackupServiceProvider);
  return await autoBackupService.getAutoBackupSettings();
});
