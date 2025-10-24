import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/event.dart';
import 'package:tempo/features/home/presentation/widgets/dashboard_card.dart';
import 'package:intl/intl.dart';

class TodayEventsCard extends ConsumerWidget {
  const TodayEventsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayEventsAsync = ref.watch(todayEventsProvider);

    return DashboardCard(
      title: 'Événements d\'aujourd\'hui',
      onTap: () => context.go('/agenda'),
      child: todayEventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return const Text('Aucun événement prévu aujourd\'hui');
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text(
          DateFormat('HH:mm').format(event.startDate),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        event.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle:
          event.hasLocation ? Text(event.location!) : Text(event.timeRange),
      isThreeLine: false,
    );
  }
}
