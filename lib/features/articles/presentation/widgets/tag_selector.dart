import 'package:flutter/material.dart';

class TagSelector extends StatefulWidget {
  final List<String> selectedTags;
  final Function(List<String>) onTagsChanged;
  final String? hintText;

  const TagSelector({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
    this.hintText,
  });

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  final TextEditingController _tagController = TextEditingController();
  final List<String> _suggestedTags = [
    // Catégories générales
    'Droit', 'Légal', 'Juridique', 'Réglementation',
    'Business', 'Entreprise', 'Management', 'Leadership',
    'Technologie', 'Innovation', 'Digital', 'IA',
    'Marketing', 'Communication', 'Vente', 'Commercial',
    'Finance', 'Économie', 'Investissement', 'Bourse',
    'RH', 'Ressources Humaines', 'Formation', 'Recrutement',
    'Santé', 'Médecine', 'Bien-être', 'Sécurité',
    'Environnement', 'Développement Durable', 'Écologie',
    'Éducation', 'Formation', 'Apprentissage',
    'Culture', 'Art', 'Littérature', 'Médias',
    'Sport', 'Loisirs', 'Voyage', 'Tourisme',

    // Mots-clés spécifiques
    'RGPD', 'Protection des données', 'Cybersécurité',
    'Transformation digitale', 'Agilité', 'Startup',
    'PME', 'Grande entreprise', 'Secteur public',
    'International', 'Export', 'Import',
    'R&D', 'Recherche', 'Développement',
    'Qualité', 'Processus', 'Optimisation',
    'Client', 'Service client', 'Satisfaction',
    'Partenaire', 'Collaboration', 'Partenariat',
    'Crise', 'Gestion de crise', 'Résilience',
    'Changement', 'Transition', 'Évolution',
  ];

  List<String> get _filteredSuggestions {
    final query = _tagController.text.toLowerCase();
    if (query.isEmpty) return _suggestedTags.take(20).toList();

    return _suggestedTags
        .where((tag) => tag.toLowerCase().contains(query))
        .take(20)
        .toList();
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tags sélectionnés
        if (widget.selectedTags.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedTags
                .map((tag) => Chip(
                      label: Text(tag),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => _removeTag(tag),
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
          const SizedBox(height: 12),
        ],

        // Champ de saisie avec suggestions
        TextField(
          controller: _tagController,
          decoration: InputDecoration(
            labelText: 'Mots-clés et tags',
            hintText: widget.hintText ??
                'Ajoutez des mots-clés pour faciliter la recherche...',
            prefixIcon: const Icon(Icons.tag),
            suffixIcon: _tagController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addCurrentTag,
                    tooltip: 'Ajouter le tag',
                  )
                : null,
          ),
          onChanged: (value) => setState(() {}),
          onSubmitted: (value) => _addCurrentTag(),
        ),

        // Suggestions
        if (_tagController.text.isNotEmpty &&
            _filteredSuggestions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _filteredSuggestions[index];
                final isSelected = widget.selectedTags.contains(suggestion);

                return ListTile(
                  dense: true,
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.add_circle_outline,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  title: Text(
                    suggestion,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  onTap: () => _toggleTag(suggestion),
                );
              },
            ),
          ),
        ],

        // Catégories prédéfinies
        const SizedBox(height: 16),
        Text(
          'Catégories populaires',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CategoryChip(
              label: 'Droit & Légal',
              icon: Icons.gavel,
              tags: ['Droit', 'Légal', 'Juridique', 'Réglementation', 'RGPD'],
              onTap: () => _addTags(['Droit', 'Légal']),
            ),
            _CategoryChip(
              label: 'Business',
              icon: Icons.business,
              tags: ['Business', 'Entreprise', 'Management', 'Leadership'],
              onTap: () => _addTags(['Business', 'Management']),
            ),
            _CategoryChip(
              label: 'Technologie',
              icon: Icons.computer,
              tags: [
                'Technologie',
                'Innovation',
                'Digital',
                'IA',
                'Cybersécurité'
              ],
              onTap: () => _addTags(['Technologie', 'Innovation']),
            ),
            _CategoryChip(
              label: 'Marketing',
              icon: Icons.campaign,
              tags: ['Marketing', 'Communication', 'Vente', 'Commercial'],
              onTap: () => _addTags(['Marketing', 'Communication']),
            ),
            _CategoryChip(
              label: 'RH',
              icon: Icons.people,
              tags: ['RH', 'Ressources Humaines', 'Formation', 'Recrutement'],
              onTap: () => _addTags(['RH', 'Formation']),
            ),
          ],
        ),
      ],
    );
  }

  void _addCurrentTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !widget.selectedTags.contains(tag)) {
      final newTags = [...widget.selectedTags, tag];
      widget.onTagsChanged(newTags);
      _tagController.clear();
    }
  }

  void _addTag(String tag) {
    if (!widget.selectedTags.contains(tag)) {
      final newTags = [...widget.selectedTags, tag];
      widget.onTagsChanged(newTags);
    }
  }

  void _addTags(List<String> tags) {
    final newTags = [...widget.selectedTags];
    for (final tag in tags) {
      if (!newTags.contains(tag)) {
        newTags.add(tag);
      }
    }
    widget.onTagsChanged(newTags);
  }

  void _removeTag(String tag) {
    final newTags = widget.selectedTags.where((t) => t != tag).toList();
    widget.onTagsChanged(newTags);
  }

  void _toggleTag(String tag) {
    if (widget.selectedTags.contains(tag)) {
      _removeTag(tag);
    } else {
      _addTag(tag);
    }
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<String> tags;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
