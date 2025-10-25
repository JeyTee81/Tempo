import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/event.dart';
import 'package:tempo/core/models/contact.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class EventDetailPage extends ConsumerWidget {
  final int eventId;

  const EventDetailPage({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventByIdProvider(eventId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'événement'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Édition - À implémenter')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteEvent(context, ref),
          ),
        ],
      ),
      body: eventAsync.when(
        data: (event) {
          if (event == null) {
            return const Center(
              child: Text('Événement non trouvé'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec icône
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.event,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event.isAllDay
                                    ? 'Toute la journée'
                                    : '${DateFormat('HH:mm', 'fr_FR').format(event.startDate)} - ${DateFormat('HH:mm', 'fr_FR').format(event.endDate)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              Text(
                                DateFormat('EEEE dd MMMM yyyy', 'fr_FR')
                                    .format(event.startDate),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                if (event.description != null &&
                    event.description!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Description',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            event.description!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Lieu
                if (event.location != null && event.location!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Lieu',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            event.location!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Informations de date
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Horaires',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildInfoItem(
                          context,
                          'Début',
                          DateFormat('EEEE dd MMMM yyyy à HH:mm', 'fr_FR')
                              .format(event.startDate),
                          Icons.play_arrow,
                        ),
                        if (!event.isAllDay) ...[
                          const SizedBox(height: 8),
                          _buildInfoItem(
                            context,
                            'Fin',
                            DateFormat('EEEE dd MMMM yyyy à HH:mm', 'fr_FR')
                                .format(event.endDate),
                            Icons.stop,
                          ),
                        ],
                        const SizedBox(height: 8),
                        _buildInfoItem(
                          context,
                          'Durée',
                          event.isAllDay
                              ? 'Toute la journée'
                              : _formatDuration(event.startDate, event.endDate),
                          Icons.timer,
                        ),
                      ],
                    ),
                  ),
                ),

                // Contacts liés
                _buildLinkedContacts(context, ref),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur: $error')),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  String _formatDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}min';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}min';
    }
  }

  Widget _buildLinkedContacts(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Contact>>(
      future: ref.read(repositoryProvider).getContactsByEvent(eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        final contacts = snapshot.data ?? [];

        if (contacts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Contacts associés (${contacts.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: contacts.map((contact) {
                    return Chip(
                      avatar: contact.hasPhoto
                          ? CircleAvatar(
                              backgroundImage:
                                  FileImage(File(contact.photoUrl!)),
                              radius: 12,
                            )
                          : CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Text(
                                contact.fullName.substring(0, 1).toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              radius: 12,
                            ),
                      label: Text(contact.fullName),
                      onDeleted: () {
                        // TODO: Implémenter la suppression du lien
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Suppression du lien - À implémenter')),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteEvent(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'événement'),
        content:
            const Text('Êtes-vous sûr de vouloir supprimer cet événement ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final repository = ref.read(repositoryProvider);
        await repository.deleteEvent(eventId);

        // Force refresh of events provider
        ref.invalidate(eventsProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Événement supprimé')),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: $e')),
          );
        }
      }
    }
  }
}
