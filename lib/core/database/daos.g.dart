// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$ContactDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $ContactsTable get contacts => attachedDatabase.contacts;
  $EventsTable get events => attachedDatabase.events;
  $EventContactsTable get eventContacts => attachedDatabase.eventContacts;
  $ArticlesTable get articles => attachedDatabase.articles;
  $ArticleContactsTable get articleContacts => attachedDatabase.articleContacts;
}
mixin _$ArticleDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $ArticlesTable get articles => attachedDatabase.articles;
  $EventsTable get events => attachedDatabase.events;
  $EventArticlesTable get eventArticles => attachedDatabase.eventArticles;
  $ContactsTable get contacts => attachedDatabase.contacts;
  $ArticleContactsTable get articleContacts => attachedDatabase.articleContacts;
}
mixin _$EventDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $EventsTable get events => attachedDatabase.events;
  $ContactsTable get contacts => attachedDatabase.contacts;
  $ArticlesTable get articles => attachedDatabase.articles;
  $EventContactsTable get eventContacts => attachedDatabase.eventContacts;
  $EventArticlesTable get eventArticles => attachedDatabase.eventArticles;
}
