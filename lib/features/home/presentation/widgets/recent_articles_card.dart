import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/article.dart';
import 'package:tempo/features/home/presentation/widgets/dashboard_card.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class RecentArticlesCard extends ConsumerWidget {
  const RecentArticlesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentArticlesAsync = ref.watch(recentArticlesProvider);

    return DashboardCard(
      title: 'Articles récents',
      onTap: () => context.go('/articles'),
      child: recentArticlesAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Text('Aucun article récent');
          }

          return Column(
            children: articles
                .take(3)
                .map((article) => _ArticleTile(article: article))
                .toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Erreur: $error'),
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final Article article;

  const _ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => context.push('/articles/${article.id}'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec icône et titre
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: article.isLocal
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      article.isLocal ? Icons.article : Icons.link,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${article.source} • ${DateFormat('dd/MM', 'fr_FR').format(article.date)}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (article.hasUrl)
                    IconButton(
                      icon: Icon(
                        article.isLocal ? Icons.open_in_new : Icons.launch,
                        size: 18,
                      ),
                      onPressed: () => _launchUrl(context, article.url!),
                      tooltip: article.isLocal
                          ? 'Ouvrir le fichier'
                          : 'Ouvrir l\'URL',
                    ),
                ],
              ),

              // Aperçu du contenu
              if (article.summary != null && article.summary!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    article.summary!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],

              // Tags
              if (article.tagList.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: article.tagList
                      .take(3)
                      .map((tag) => Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 10,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ],

              // Informations sur le fichier (si local)
              if (article.isLocal && article.hasUrl) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _getFileIcon(article.url!),
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _getFileName(article.url!),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      _getFileSize(article.url!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (url.startsWith('http')) {
      // URL externe
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } else {
      // Fichier local
      final file = File(url);
      if (file.existsSync()) {
        final uri = Uri.file(file.path);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Impossible d\'ouvrir le fichier: ${file.path}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fichier non trouvé')),
        );
      }
    }
  }

  IconData _getFileIcon(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'txt':
        return Icons.text_snippet;
      case 'rtf':
        return Icons.article;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }

  String _getFileSize(String path) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        final bytes = file.lengthSync();
        if (bytes < 1024) return '$bytes B';
        if (bytes < 1024 * 1024)
          return '${(bytes / 1024).toStringAsFixed(1)} KB';
        return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      }
    } catch (e) {
      // Ignore errors
    }
    return '';
  }
}
