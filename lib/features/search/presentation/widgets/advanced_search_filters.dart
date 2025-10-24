import 'package:flutter/material.dart';
import 'package:tempo/core/models/search_result.dart';

class AdvancedSearchFilters extends StatefulWidget {
  final List<String> selectedTags;
  final Function(List<String>) onTagsChanged;
  final SearchResultType? selectedType;
  final Function(SearchResultType?) onTypeChanged;

  const AdvancedSearchFilters({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
    this.selectedType,
    required this.onTypeChanged,
  });

  @override
  State<AdvancedSearchFilters> createState() => _AdvancedSearchFiltersState();
}

class _AdvancedSearchFiltersState extends State<AdvancedSearchFilters> {
  final List<String> _popularTags = [
    'Droit',
    'Légal',
    'Business',
    'Management',
    'Technologie',
    'Innovation',
    'Marketing',
    'Communication',
    'RH',
    'Finance',
    'Santé',
    'Environnement',
    'LinkedIn',
    'Article',
    'Post',
    'Publication',
    'Recherche',
    'Formation',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Filtres avancés',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type de contenu
            Text(
              'Type de contenu',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Tous'),
                  selected: widget.selectedType == null,
                  onSelected: (selected) {
                    widget.onTypeChanged(selected ? null : widget.selectedType);
                  },
                ),
                FilterChip(
                  label: const Text('Contacts'),
                  selected: widget.selectedType == SearchResultType.contact,
                  onSelected: (selected) {
                    widget.onTypeChanged(
                        selected ? SearchResultType.contact : null);
                  },
                ),
                FilterChip(
                  label: const Text('Articles'),
                  selected: widget.selectedType == SearchResultType.article,
                  onSelected: (selected) {
                    widget.onTypeChanged(
                        selected ? SearchResultType.article : null);
                  },
                ),
                FilterChip(
                  label: const Text('Événements'),
                  selected: widget.selectedType == SearchResultType.event,
                  onSelected: (selected) {
                    widget.onTypeChanged(
                        selected ? SearchResultType.event : null);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tags populaires
            Text(
              'Tags populaires',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _popularTags.map((tag) {
                final isSelected = widget.selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    final newTags = List<String>.from(widget.selectedTags);
                    if (selected) {
                      if (!newTags.contains(tag)) {
                        newTags.add(tag);
                      }
                    } else {
                      newTags.remove(tag);
                    }
                    widget.onTagsChanged(newTags);
                  },
                );
              }).toList(),
            ),

            // Tags sélectionnés
            if (widget.selectedTags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Tags sélectionnés',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.selectedTags
                    .map((tag) => Chip(
                          label: Text(tag),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            final newTags =
                                List<String>.from(widget.selectedTags);
                            newTags.remove(tag);
                            widget.onTagsChanged(newTags);
                          },
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                    .toList(),
              ),
            ],

            // Actions
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      widget.onTagsChanged([]);
                      widget.onTypeChanged(null);
                    },
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Effacer tout'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Rechercher'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
