import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/article.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ArticleDetailPage extends ConsumerWidget {
  final int articleId;

  const ArticleDetailPage({
    super.key,
    required this.articleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleAsync = ref.watch(articleByIdProvider(articleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'article'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Édition - À implémenter')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteArticle(context, ref),
          ),
        ],
      ),
      body: articleAsync.when(
        data: (article) {
          if (article == null) {
            return const Center(
              child: Text('Article non trouvé'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec icône
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: article.isLocal
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          child: Icon(
                            article.isLocal ? Icons.article : Icons.link,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                article.displaySource,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy', 'fr_FR')
                                    .format(article.date),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (article.hasUrl)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _launchUrl(context, article.url!),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  article.isLocal
                                      ? Icons.open_in_new
                                      : Icons.launch,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Résumé
                if (article.summary != null && article.summary!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Résumé',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            article.summary!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Tags
                if (article.tagList.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.tag,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Tags',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: article.tagList
                                .map((tag) => Chip(
                                      label: Text(tag),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Informations techniques
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Informations',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          label: 'Type',
                          value: article.isLocal
                              ? 'Article local'
                              : 'Lien externe',
                          icon: article.isLocal ? Icons.article : Icons.link,
                        ),
                        _InfoRow(
                          label: 'Source',
                          value: article.source,
                          icon: Icons.source,
                        ),
                        if (article.hasUrl)
                          _InfoRow(
                            label: 'URL',
                            value: article.url!,
                            icon: Icons.link,
                            isUrl: true,
                          ),
                        _InfoRow(
                          label: 'Date de création',
                          value: DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR')
                              .format(article.createdAt),
                          icon: Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Erreur: $error'),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      if (url.startsWith('http')) {
        // URL externe
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Impossible d\'ouvrir l\'URL: $url')),
          );
        }
      } else {
        // Fichier local
        final file = File(url);
        if (file.existsSync()) {
          final uri = Uri.file(file.path);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            // Essayer avec le chemin absolu
            final absoluteUri = Uri.file(file.absolute.path);
            if (await canLaunchUrl(absoluteUri)) {
              await launchUrl(absoluteUri,
                  mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Impossible d\'ouvrir le fichier: ${file.path}')),
              );
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fichier non trouvé: ${file.path}')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ouverture: $e')),
      );
    }
  }

  Future<void> _deleteArticle(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'article'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
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
        final repository = ref.read(repositoryProvider);
        await repository.deleteArticle(articleId);

        // Force refresh of articles provider
        ref.invalidate(articlesProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Article supprimé')),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: $e')),
          );
        }
      }
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isUrl;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    this.isUrl = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isUrl
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        decoration: isUrl ? TextDecoration.underline : null,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
