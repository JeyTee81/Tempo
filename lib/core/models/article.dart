import 'package:tempo/core/database/database.dart';

// Extension to convert Drift Article to domain model
extension ArticleExtension on Article {
  List<String> get tagList {
    if (tags == null || tags!.isEmpty) return [];
    return tags!
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }

  bool get isExternal => !isLocal;

  String get displaySource {
    if (isLocal) return 'Local';
    return source;
  }

  String get shortSummary {
    if (summary == null || summary!.isEmpty) return '';
    if (summary!.length <= 100) return summary!;
    return '${summary!.substring(0, 100)}...';
  }

  bool get hasUrl => url != null && url!.isNotEmpty;
}
