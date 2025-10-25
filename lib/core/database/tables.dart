import 'package:drift/drift.dart';

// Users table (for future multi-user support)
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 100)();
  TextColumn get lastName => text().withLength(min: 1, max: 100)();
  TextColumn get email => text().withLength(max: 100).unique()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get role =>
      text().withLength(max: 50).withDefault(const Constant('user'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastLoginAt => dateTime().nullable()();
}

// Contacts table
class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id).nullable()(); // For future multi-user
  TextColumn get firstName => text().withLength(min: 1, max: 100)();
  TextColumn get lastName => text().withLength(min: 1, max: 100)();
  TextColumn get jobTitle => text().nullable()();
  TextColumn get company => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

// Articles table
class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id).nullable()(); // For future multi-user
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get source => text().withLength(min: 1, max: 100)();
  TextColumn get url => text().nullable()();
  TextColumn get summary => text().nullable()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get tags => text().nullable()();
  BoolColumn get isLocal => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Events table
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id).nullable()(); // For future multi-user
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get location => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();
}

// Junction table for Events and Contacts (many-to-many)
class EventContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get contactId =>
      integer().references(Contacts, #id, onDelete: KeyAction.cascade)();
}

// Junction table for Events and Articles (many-to-many)
class EventArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get articleId =>
      integer().references(Articles, #id, onDelete: KeyAction.cascade)();
}

// Junction table for Articles and Contacts (many-to-many)
class ArticleContacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get articleId =>
      integer().references(Articles, #id, onDelete: KeyAction.cascade)();
  IntColumn get contactId =>
      integer().references(Contacts, #id, onDelete: KeyAction.cascade)();
}
