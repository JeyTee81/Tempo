import 'package:drift/drift.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/database/tables.dart';
import 'package:tempo/core/models/contact.dart';
import 'package:tempo/core/models/article.dart';
import 'package:tempo/core/models/event.dart';
import 'package:tempo/core/models/search_result.dart';

class DataRepository {
  final AppDatabase _database;

  DataRepository(this._database);

  // Contact operations
  Future<List<Contact>> getAllContacts() =>
      _database.contactDao.getAllContacts();

  Future<Contact?> getContactById(int id) =>
      _database.contactDao.getContactById(id);

  Future<List<Contact>> searchContacts(String query) =>
      _database.contactDao.searchContacts(query);

  Future<int> insertContact(ContactsCompanion contact) =>
      _database.contactDao.insertContact(contact);

  Future<bool> updateContact(Contact contact) =>
      _database.contactDao.updateContact(contact);

  Future<int> deleteContact(int id) => _database.contactDao.deleteContact(id);

  // Article operations
  Future<List<Article>> getAllArticles() =>
      _database.articleDao.getAllArticles();

  Future<Article?> getArticleById(int id) =>
      _database.articleDao.getArticleById(id);

  Future<List<Article>> searchArticles(String query) =>
      _database.articleDao.searchArticles(query);

  Future<int> insertArticle(ArticlesCompanion article) =>
      _database.articleDao.insertArticle(article);

  Future<bool> updateArticle(Article article) =>
      _database.articleDao.updateArticle(article);

  Future<int> deleteArticle(int id) => _database.articleDao.deleteArticle(id);

  // Event operations
  Future<List<Event>> getAllEvents() => _database.eventDao.getAllEvents();

  Future<Event?> getEventById(int id) => _database.eventDao.getEventById(id);

  Future<List<Event>> getEventsByDateRange(DateTime start, DateTime end) =>
      _database.eventDao.getEventsByDateRange(start, end);

  Future<List<Event>> searchEvents(String query) =>
      _database.eventDao.searchEvents(query);

  Future<int> insertEvent(EventsCompanion event) =>
      _database.eventDao.insertEvent(event);

  Future<bool> updateEvent(Event event) =>
      _database.eventDao.updateEvent(event);

  Future<int> deleteEvent(int id) => _database.eventDao.deleteEvent(id);

  // Relationship operations
  Future<void> linkEventToContact(int eventId, int contactId) =>
      _database.eventDao.linkEventToContact(eventId, contactId);

  Future<void> linkEventToArticle(int eventId, int articleId) =>
      _database.eventDao.linkEventToArticle(eventId, articleId);

  Future<void> unlinkEventFromContact(int eventId, int contactId) =>
      _database.eventDao.unlinkEventFromContact(eventId, contactId);

  Future<void> unlinkEventFromArticle(int eventId, int articleId) =>
      _database.eventDao.unlinkEventFromArticle(eventId, articleId);

  Future<List<Contact>> getContactsByEvent(int eventId) =>
      _database.contactDao.getContactsByEvent(eventId);

  Future<List<Article>> getArticlesByEvent(int eventId) =>
      _database.articleDao.getArticlesByEvent(eventId);

  // Article-Contact relationship operations
  Future<void> linkArticleToContact(int articleId, int contactId) =>
      _database.articleDao.linkArticleToContact(articleId, contactId);

  Future<void> unlinkArticleFromContact(int articleId, int contactId) =>
      _database.articleDao.unlinkArticleFromContact(articleId, contactId);

  Future<List<Contact>> getContactsByArticle(int articleId) =>
      _database.contactDao.getContactsByArticle(articleId);

  // Global search
  Future<List<SearchResult>> globalSearch(String query) async {
    if (query.isEmpty) return [];

    final results = <SearchResult>[];

    // Search contacts
    final contacts = await searchContacts(query);
    for (final contact in contacts) {
      results.add(
        SearchResult(
          type: SearchResultType.contact,
          id: contact.id,
          title: contact.fullName,
          subtitle: contact.displayTitle,
          imageUrl: contact.photoUrl,
        ),
      );
    }

    // Search articles
    final articles = await searchArticles(query);
    for (final article in articles) {
      results.add(
        SearchResult(
          type: SearchResultType.article,
          id: article.id,
          title: article.title,
          subtitle: article.shortSummary,
          date: article.date,
        ),
      );
    }

    // Search events
    final events = await searchEvents(query);
    for (final event in events) {
      results.add(
        SearchResult(
          type: SearchResultType.event,
          id: event.id,
          title: event.title,
          subtitle:
              '${event.timeRange}${event.hasLocation ? ' • ${event.location}' : ''}',
          date: event.startDate,
        ),
      );
    }

    return results;
  }

  // Dashboard data
  Future<List<Event>> getTodayEvents() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return getEventsByDateRange(startOfDay, endOfDay);
  }

  Future<List<Event>> getUpcomingEvents({int limit = 5}) async {
    final now = DateTime.now();
    final events = await getAllEvents();
    return events.where((event) => event.startDate.isAfter(now)).toList()
      ..sort((a, b) => a.startDate.compareTo(b.startDate))
      ..take(limit);
  }

  Future<List<Article>> getRecentArticles({int limit = 5}) async {
    final articles = await getAllArticles();
    return articles
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt))
      ..take(limit);
  }
}
