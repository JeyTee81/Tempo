import 'package:drift/drift.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/database/tables.dart';

part 'daos.g.dart';

// Contact DAO
@DriftAccessor(tables: [Contacts, Events, EventContacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(AppDatabase db) : super(db);

  Future<List<Contact>> getAllContacts() => select(contacts).get();

  Future<Contact?> getContactById(int id) =>
      (select(contacts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<Contact>> searchContacts(String query) =>
      (select(contacts)..where(
            (tbl) =>
                tbl.firstName.contains(query) |
                tbl.lastName.contains(query) |
                tbl.company.contains(query) |
                tbl.jobTitle.contains(query),
          ))
          .get();

  Future<int> insertContact(ContactsCompanion contact) =>
      into(contacts).insert(contact);

  Future<bool> updateContact(Contact contact) =>
      update(contacts).replace(contact);

  Future<int> deleteContact(int id) =>
      (delete(contacts)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<Contact>> getContactsByEvent(int eventId) async {
    final query = select(contacts).join([
      innerJoin(eventContacts, eventContacts.contactId.equalsExp(contacts.id)),
    ])..where(eventContacts.eventId.equals(eventId));

    return query.map((row) => row.readTable(contacts)).get();
  }
}

// Article DAO
@DriftAccessor(tables: [Articles, Events, EventArticles])
class ArticleDao extends DatabaseAccessor<AppDatabase> with _$ArticleDaoMixin {
  ArticleDao(AppDatabase db) : super(db);

  Future<List<Article>> getAllArticles() => select(articles).get();

  Future<Article?> getArticleById(int id) =>
      (select(articles)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<Article>> searchArticles(String query) =>
      (select(articles)..where(
            (tbl) =>
                tbl.title.contains(query) |
                tbl.summary.contains(query) |
                tbl.tags.contains(query),
          ))
          .get();

  Future<int> insertArticle(ArticlesCompanion article) =>
      into(articles).insert(article);

  Future<bool> updateArticle(Article article) =>
      update(articles).replace(article);

  Future<int> deleteArticle(int id) =>
      (delete(articles)..where((tbl) => tbl.id.equals(id))).go();

  Future<List<Article>> getArticlesByEvent(int eventId) async {
    final query = select(articles).join([
      innerJoin(eventArticles, eventArticles.articleId.equalsExp(articles.id)),
    ])..where(eventArticles.eventId.equals(eventId));

    return query.map((row) => row.readTable(articles)).get();
  }
}

// Event DAO
@DriftAccessor(
  tables: [Events, Contacts, Articles, EventContacts, EventArticles],
)
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(AppDatabase db) : super(db);

  Future<List<Event>> getAllEvents() => select(events).get();

  Future<Event?> getEventById(int id) =>
      (select(events)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<List<Event>> getEventsByDateRange(DateTime start, DateTime end) =>
      (select(events)..where(
            (tbl) =>
                tbl.startDate.isBiggerOrEqualValue(start) &
                tbl.startDate.isSmallerOrEqualValue(end),
          ))
          .get();

  Future<List<Event>> searchEvents(String query) =>
      (select(events)..where(
            (tbl) =>
                tbl.title.contains(query) |
                tbl.description.contains(query) |
                tbl.location.contains(query),
          ))
          .get();

  Future<int> insertEvent(EventsCompanion event) => into(events).insert(event);

  Future<bool> updateEvent(Event event) => update(events).replace(event);

  Future<int> deleteEvent(int id) =>
      (delete(events)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> linkEventToContact(int eventId, int contactId) async {
    await into(eventContacts).insert(
      EventContactsCompanion(
        eventId: Value(eventId),
        contactId: Value(contactId),
      ),
    );
  }

  Future<void> linkEventToArticle(int eventId, int articleId) async {
    await into(eventArticles).insert(
      EventArticlesCompanion(
        eventId: Value(eventId),
        articleId: Value(articleId),
      ),
    );
  }

  Future<void> unlinkEventFromContact(int eventId, int contactId) async {
    await (delete(eventContacts)..where(
          (tbl) =>
              tbl.eventId.equals(eventId) & tbl.contactId.equals(contactId),
        ))
        .go();
  }

  Future<void> unlinkEventFromArticle(int eventId, int articleId) async {
    await (delete(eventArticles)..where(
          (tbl) =>
              tbl.eventId.equals(eventId) & tbl.articleId.equals(articleId),
        ))
        .go();
  }
}
