import 'package:flutter/material.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/event.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final Event event;

  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: event.isToday
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.description != null && event.description!.isNotEmpty)
              Text(
                event.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  event.timeRange,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (event.hasLocation) ...[
                  const SizedBox(width: 16),
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.location!,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // TODO: Navigate to event details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Détails de l\'événement: ${event.title}')),
          );
        },
      ),
    );
  }
}
