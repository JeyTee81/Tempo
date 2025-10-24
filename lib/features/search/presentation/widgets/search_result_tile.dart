import 'package:flutter/material.dart';
import 'package:tempo/core/models/search_result.dart';
import 'package:intl/intl.dart';

class SearchResultTile extends StatelessWidget {
  final SearchResult result;
  final VoidCallback? onTap;

  const SearchResultTile({super.key, required this.result, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(context),
          child: result.imageUrl != null
              ? ClipOval(
                  child: Image.network(
                    result.imageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Text(
                      result.typeIcon,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : Text(result.typeIcon, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(
          result.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.subtitle),
            if (result.date != null)
              Text(
                DateFormat('dd MMMM yyyy', 'fr_FR').format(result.date!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        trailing: Chip(
          label: Text(result.typeLabel),
          backgroundColor: _getTypeColor(context).withOpacity(0.1),
          labelStyle: TextStyle(color: _getTypeColor(context), fontSize: 12),
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getTypeColor(BuildContext context) {
    switch (result.type) {
      case SearchResultType.contact:
        return Theme.of(context).colorScheme.primary;
      case SearchResultType.article:
        return Theme.of(context).colorScheme.secondary;
      case SearchResultType.event:
        return Theme.of(context).colorScheme.tertiary;
    }
  }
}
