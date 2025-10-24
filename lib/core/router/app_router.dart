import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempo/features/home/presentation/pages/home_page.dart';
import 'package:tempo/features/agenda/presentation/pages/agenda_page.dart';
import 'package:tempo/features/contacts/presentation/pages/contacts_page.dart';
import 'package:tempo/features/contacts/presentation/pages/add_contact_page.dart';
import 'package:tempo/features/contacts/presentation/pages/contact_detail_page.dart';
import 'package:tempo/features/articles/presentation/pages/articles_page.dart';
import 'package:tempo/features/articles/presentation/pages/add_article_page.dart';
import 'package:tempo/features/articles/presentation/pages/article_detail_page.dart';
import 'package:tempo/features/search/presentation/pages/search_page.dart';
import 'package:tempo/features/backup/presentation/pages/backup_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/agenda',
            name: 'agenda',
            builder: (context, state) => const AgendaPage(),
          ),
          GoRoute(
            path: '/contacts',
            name: 'contacts',
            builder: (context, state) => const ContactsPage(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'add-contact',
                builder: (context, state) => const AddContactPage(),
              ),
              GoRoute(
                path: ':id',
                name: 'contact-detail',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return ContactDetailPage(contactId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/articles',
            name: 'articles',
            builder: (context, state) => const ArticlesPage(),
            routes: [
              GoRoute(
                path: 'add',
                name: 'add-article',
                builder: (context, state) => const AddArticlePage(),
              ),
              GoRoute(
                path: ':id',
                name: 'article-detail',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return ArticleDetailPage(articleId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/backup',
            name: 'backup',
            builder: (context, state) => const BackupPage(),
          ),
        ],
      ),
    ],
  );
});

class MainNavigationWrapper extends ConsumerWidget {
  final Widget child;

  const MainNavigationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Articles',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 0;
      case '/agenda':
        return 1;
      case '/contacts':
        return 2;
      case '/articles':
        return 3;
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/agenda');
        break;
      case 2:
        context.go('/contacts');
        break;
      case 3:
        context.go('/articles');
        break;
    }
  }
}
