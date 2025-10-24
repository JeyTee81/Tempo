import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/event.dart';
import 'package:tempo/features/home/presentation/widgets/dashboard_card.dart';
import 'package:intl/intl.dart';

class UpcomingEventsCard extends ConsumerWidget {
  const UpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);

    return DashboardCard(
      title: 'Prochains événements',
      onTap: () => context.go('/agenda'),
      child: upcomingEventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return const Text('Aucun événement à venir');
          }

          return Column(
            children: events
                .take(3)
                .map((event) => _EventTile(event: event))
                .toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Erreur: $error'),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(
          DateFormat('dd/MM').format(event.startDate),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        event.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${DateFormat('EEEE dd MMMM', 'fr_FR').format(event.startDate)} • ${event.timeRange}',
      ),
      isThreeLine: false,
    );
  }
}
