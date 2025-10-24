import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tempo/core/services/backup_service.dart';
import 'package:tempo/features/backup/presentation/widgets/backup_help_card.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final backupService = ref.watch(backupServiceProvider);
    final backupStatsAsync = ref.watch(backupStatsProvider);
    final availableBackupsAsync = ref.watch(availableBackupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sauvegarde et Restauration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(backupStatsProvider);
              ref.invalidate(availableBackupsProvider);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistiques actuelles
            _buildStatsCard(backupStatsAsync),
            const SizedBox(height: 24),

            // Actions de sauvegarde
            _buildBackupActionsCard(backupService),
            const SizedBox(height: 24),

            // Carte d'aide
            const BackupHelpCard(),
            const SizedBox(height: 24),

            // Liste des sauvegardes
            _buildBackupsListCard(availableBackupsAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(AsyncValue<BackupStats> statsAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Statistiques Actuelles',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            statsAsync.when(
              data: (stats) => Column(
                children: [
                  _buildStatRow('Utilisateurs', stats.userCount.toString()),
                  _buildStatRow('Contacts', stats.contactCount.toString()),
                  _buildStatRow('Articles', stats.articleCount.toString()),
                  _buildStatRow('Événements', stats.eventCount.toString()),
                  const Divider(),
                  _buildStatRow('Taille totale', stats.formattedTotalSize),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Erreur: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupActionsCard(BackupService backupService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.backup,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Actions de Sauvegarde',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                // Boutons principaux
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () => _createBackup(backupService),
                        icon: _isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save),
                        label: const Text('Sauvegarde Rapide'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () => _restoreFromFile(backupService),
                        icon: const Icon(Icons.restore),
                        label: const Text('Restaurer'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Boutons avancés
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () => _createBackupWithLocation(backupService),
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Sauvegarder où...'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () => _restoreWithFilePicker(backupService),
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Restaurer depuis...'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Créer une sauvegarde de toutes vos données (contacts, articles, événements) pour les restaurer plus tard.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupsListCard(AsyncValue<List<BackupFileInfo>> backupsAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.folder,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sauvegardes Disponibles',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            backupsAsync.when(
              data: (backups) {
                if (backups.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('Aucune sauvegarde disponible'),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: backups.length,
                  itemBuilder: (context, index) {
                    final backup = backups[index];
                    return _buildBackupItem(backup);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Erreur: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupItem(BackupFileInfo backup) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(
            Icons.backup,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(backup.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Créé le ${backup.formattedDate}'),
            Text(
              '${backup.contactCount} contacts • ${backup.articleCount} articles • ${backup.eventCount} événements',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Taille: ${backup.formattedSize}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) => _handleBackupAction(action, backup),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'restore',
              child: Row(
                children: [
                  Icon(Icons.restore),
                  SizedBox(width: 8),
                  Text('Restaurer'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createBackup(BackupService backupService) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final file = await backupService.saveBackupToFile();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sauvegarde créée: ${file.path}'),
            action: SnackBarAction(
              label: 'Ouvrir',
              onPressed: () => _openFileLocation(file),
            ),
          ),
        );

        // Rafraîchir la liste des sauvegardes
        ref.invalidate(availableBackupsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sauvegarde: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _restoreFromFile(BackupService backupService) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        // Demander confirmation
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmer la restauration'),
            content: const Text(
              'Cette action va remplacer toutes vos données actuelles par celles de la sauvegarde. '
              'Voulez-vous continuer ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Restaurer'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await backupService.restoreFromFile(file);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Données restaurées avec succès')),
            );

            // Rafraîchir les données
            ref.invalidate(availableBackupsProvider);
            ref.invalidate(backupStatsProvider);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la restauration: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createBackupWithLocation(BackupService backupService) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final file = await backupService.saveBackupWithLocationPicker();

      if (file != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sauvegarde créée: ${file.path}'),
            action: SnackBarAction(
              label: 'Ouvrir',
              onPressed: () => _openFileLocation(file),
            ),
          ),
        );

        // Rafraîchir la liste des sauvegardes
        ref.invalidate(availableBackupsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sauvegarde: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _restoreWithFilePicker(BackupService backupService) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Demander confirmation
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmer la restauration'),
          content: const Text(
            'Cette action va remplacer toutes vos données actuelles par celles de la sauvegarde. '
            'Voulez-vous continuer ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Restaurer'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await backupService.restoreWithFilePicker();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Données restaurées avec succès')),
          );

          // Rafraîchir les données
          ref.invalidate(availableBackupsProvider);
          ref.invalidate(backupStatsProvider);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la restauration: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleBackupAction(String action, BackupFileInfo backup) async {
    final backupService = ref.read(backupServiceProvider);

    switch (action) {
      case 'restore':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmer la restauration'),
            content: Text(
              'Restaurer la sauvegarde "${backup.name}" ? '
              'Toutes les données actuelles seront remplacées.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Restaurer'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          try {
            await backupService.restoreFromFile(backup.file);

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Données restaurées avec succès')),
              );

              ref.invalidate(availableBackupsProvider);
              ref.invalidate(backupStatsProvider);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erreur: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
        break;

      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Supprimer la sauvegarde'),
            content: Text('Supprimer définitivement "${backup.name}" ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Supprimer'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          try {
            await backupService.deleteBackup(backup.file);

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sauvegarde supprimée')),
              );

              ref.invalidate(availableBackupsProvider);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erreur: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
        break;
    }
  }

  void _openFileLocation(File file) {
    // Ouvrir l'explorateur de fichiers à l'emplacement du fichier
    // Cette fonctionnalité dépend de la plateforme
  }
}

/// Providers pour les données de sauvegarde
final backupStatsProvider = FutureProvider<BackupStats>((ref) async {
  final backupService = ref.watch(backupServiceProvider);
  return await backupService.getBackupStats();
});

final availableBackupsProvider =
    FutureProvider<List<BackupFileInfo>>((ref) async {
  final backupService = ref.watch(backupServiceProvider);
  return await backupService.getAvailableBackups();
});
