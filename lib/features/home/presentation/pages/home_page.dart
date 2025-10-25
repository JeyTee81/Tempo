import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/features/home/presentation/widgets/dashboard_card.dart';
import 'package:tempo/features/home/presentation/widgets/today_events_card.dart';
import 'package:tempo/features/home/presentation/widgets/upcoming_events_card.dart';
import 'package:tempo/features/home/presentation/widgets/recent_articles_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.backup),
            onPressed: () => context.go('/backup'),
            tooltip: 'Sauvegarde',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.go('/search'),
            tooltip: 'Rechercher',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome message
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bonjour !',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Voici un résumé de votre journée',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Today's events
            const TodayEventsCard(),
            const SizedBox(height: 20),

            // Upcoming events
            const UpcomingEventsCard(),
            const SizedBox(height: 20),

            // Recent articles
            const RecentArticlesCard(),
            const SizedBox(height: 20),

            // Quick actions
            DashboardCard(
              title: 'Actions rapides',
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: const Text('Nouvel événement'),
                    subtitle: const Text('Ajouter un événement à l\'agenda'),
                    onTap: () => context.go('/agenda'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      child: Icon(
                        Icons.person_add_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    title: const Text('Nouveau contact'),
                    subtitle: const Text('Ajouter un contact'),
                    onTap: () => context.go('/contacts'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.1),
                      child: Icon(
                        Icons.article_outlined,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    title: const Text('Nouvel article'),
                    subtitle: const Text('Ajouter un article'),
                    onTap: () => context.go('/articles'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    title: const Text('Recherche globale'),
                    subtitle: const Text('Rechercher dans tous les contenus'),
                    onTap: () => context.go('/search'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
