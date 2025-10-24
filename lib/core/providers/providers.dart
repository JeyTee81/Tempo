import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/repositories/data_repository.dart';
import 'package:tempo/core/models/search_result.dart';

// Repository provider
final repositoryProvider = Provider<DataRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return DataRepository(database);
});

// Contact providers
final contactsProvider = FutureProvider<List<Contact>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getAllContacts();
});

final contactByIdProvider = FutureProvider.family<Contact?, int>((
  ref,
  id,
) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getContactById(id);
});

// Article providers
final articlesProvider = FutureProvider<List<Article>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getAllArticles();
});

final articleByIdProvider = FutureProvider.family<Article?, int>((
  ref,
  id,
) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getArticleById(id);
});

// Event providers
final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getAllEvents();
});

final eventByIdProvider = FutureProvider.family<Event?, int>((ref, id) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getEventById(id);
});

final eventsByDateRangeProvider =
    FutureProvider.family<List<Event>, ({DateTime start, DateTime end})>((
  ref,
  dateRange,
) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getEventsByDateRange(dateRange.start, dateRange.end);
});

// Search providers
final searchQueryProvider = StateProvider<String>((ref) => '');
final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(repositoryProvider);
  return repository.globalSearch(query);
});

// Dashboard providers
final todayEventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getTodayEvents();
});

final upcomingEventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getUpcomingEvents();
});

final recentArticlesProvider = FutureProvider<List<Article>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getRecentArticles();
});
