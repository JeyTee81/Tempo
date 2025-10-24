import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/article.dart';
import 'package:intl/intl.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: article.isLocal
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          child: Icon(
            article.isLocal ? Icons.article : Icons.link,
            color: Colors.white,
          ),
        ),
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.shortSummary.isNotEmpty)
              Text(
                article.shortSummary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.source,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  article.displaySource,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd MMM yyyy', 'fr_FR').format(article.date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            if (article.tagList.isNotEmpty) ...[
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: article.tagList
                    .take(3)
                    .map(
                      (tag) => Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceVariant,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
        isThreeLine: true,
        trailing: article.hasUrl
            ? IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () => _launchUrl(article.url!),
              )
            : null,
        onTap: () => context.push('/articles/${article.id}'),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
