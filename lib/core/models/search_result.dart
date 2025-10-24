enum SearchResultType { contact, article, event }

class SearchResult {
  final SearchResultType type;
  final int id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final DateTime? date;
  final int? relevanceScore;

  const SearchResult({
    required this.type,
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.date,
    this.relevanceScore,
  });

  String get typeLabel {
    switch (type) {
      case SearchResultType.contact:
        return 'Contact';
      case SearchResultType.article:
        return 'Article';
      case SearchResultType.event:
        return 'Event';
    }
  }

  String get typeIcon {
    switch (type) {
      case SearchResultType.contact:
        return '👤';
      case SearchResultType.article:
        return '📰';
      case SearchResultType.event:
        return '📅';
    }
  }
}
