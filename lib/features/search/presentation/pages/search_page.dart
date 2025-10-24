import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/models/search_result.dart';
import 'package:tempo/features/search/presentation/widgets/search_result_tile.dart';
import 'package:tempo/features/search/presentation/widgets/advanced_search_filters.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  List<String> _selectedTags = [];
  SearchResultType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
            tooltip: 'Filtres avancés',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText:
                    'Rechercher dans les événements, contacts et articles...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              controller: TextEditingController(text: searchQuery),
            ),
          ),

          // Search results
          Expanded(
            child: searchResultsAsync.when(
              data: (results) {
                if (searchQuery.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Tapez quelque chose pour commencer la recherche',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                if (results.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Aucun résultat trouvé',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return SearchResultTile(
                      result: result,
                      onTap: () => _handleResultTap(context, result),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Erreur: $error')),
            ),
          ),
        ],
      ),
    );
  }

  void _handleResultTap(BuildContext context, SearchResult result) {
    switch (result.type) {
      case SearchResultType.contact:
        context.go('/contacts');
        break;
      case SearchResultType.article:
        context.go('/articles');
        break;
      case SearchResultType.event:
        context.go('/agenda');
        break;
    }
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => AdvancedSearchFilters(
          selectedTags: _selectedTags,
          onTagsChanged: (tags) {
            setState(() {
              _selectedTags = tags;
            });
          },
          selectedType: _selectedType,
          onTypeChanged: (type) {
            setState(() {
              _selectedType = type as SearchResultType?;
            });
          },
        ),
      ),
    );
  }

  String _getActiveFiltersText() {
    final parts = <String>[];
    if (_selectedType != null) {
      parts.add(_selectedType!.name);
    }
    if (_selectedTags.isNotEmpty) {
      parts.add('${_selectedTags.length} tag(s)');
    }
    return parts.join(', ');
  }
}
