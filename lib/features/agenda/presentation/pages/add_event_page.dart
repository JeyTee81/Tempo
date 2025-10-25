import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/contact.dart';

class AddEventPage extends ConsumerStatefulWidget {
  const AddEventPage({super.key});

  @override
  ConsumerState<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends ConsumerState<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  bool _isAllDay = false;
  bool _isLoading = false;
  List<Contact> _selectedContacts = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvel événement'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveEvent,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Sauvegarder'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations de base
              _buildSection(
                title: 'Informations de base',
                icon: Icons.event,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titre *',
                      hintText: 'Réunion, Rendez-vous...',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le titre est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Détails de l\'événement...',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date et heure
              _buildSection(
                title: 'Date et heure',
                icon: Icons.schedule,
                children: [
                  SwitchListTile(
                    title: const Text('Toute la journée'),
                    subtitle: const Text(
                        'Cocher si l\'événement dure toute la journée'),
                    value: _isAllDay,
                    onChanged: (value) {
                      setState(() {
                        _isAllDay = value;
                        if (value) {
                          _startDate = DateTime(_startDate.year,
                              _startDate.month, _startDate.day);
                          _endDate = DateTime(_startDate.year, _startDate.month,
                              _startDate.day, 23, 59);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.event_available),
                    title: const Text('Date de début'),
                    subtitle: Text(_formatDateTime(_startDate)),
                    onTap: () => _selectStartDate(),
                  ),
                  if (!_isAllDay) ...[
                    ListTile(
                      leading: const Icon(Icons.event_busy),
                      title: const Text('Date de fin'),
                      subtitle: Text(_formatDateTime(_endDate)),
                      onTap: () => _selectEndDate(),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Lieu
              _buildSection(
                title: 'Lieu',
                icon: Icons.location_on,
                children: [
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Lieu',
                      hintText: 'Bureau, Salle de réunion...',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Contacts associés
              _buildSection(
                title: 'Contacts associés',
                icon: Icons.people,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _selectContacts,
                          icon: const Icon(Icons.add),
                          label: const Text('Ajouter des contacts'),
                        ),
                      ),
                    ],
                  ),
                  if (_selectedContacts.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Contacts sélectionnés (${_selectedContacts.length})',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedContacts.map((contact) {
                        return Chip(
                          label: Text(contact.fullName),
                          onDeleted: () {
                            setState(() {
                              _selectedContacts.remove(contact);
                            });
                          },
                          deleteIcon: const Icon(Icons.close, size: 16),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),

              // Boutons d'action
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _clearForm,
                      icon: const Icon(Icons.clear),
                      label: const Text('Effacer'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _saveEvent,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save),
                      label: const Text('Sauvegarder'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    if (_isAllDay) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} à ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      if (_isAllDay) {
        setState(() {
          _startDate = date;
          _endDate = DateTime(date.year, date.month, date.day, 23, 59);
        });
      } else {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_startDate),
        );
        if (time != null) {
          setState(() {
            _startDate = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            if (_endDate.isBefore(_startDate)) {
              _endDate = _startDate.add(const Duration(hours: 1));
            }
          });
        }
      }
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_endDate),
      );
      if (time != null) {
        setState(() {
          _endDate =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _locationController.clear();
    setState(() {
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(const Duration(hours: 1));
      _isAllDay = false;
      _selectedContacts.clear();
    });
  }

  Future<void> _selectContacts() async {
    final contacts = await showDialog<List<Contact>>(
      context: context,
      builder: (context) => _ContactSelectionDialog(
        selectedContacts: _selectedContacts,
      ),
    );

    if (contacts != null) {
      setState(() {
        _selectedContacts = contacts;
      });
    }
  }

  Future<void> _saveEvent() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_isAllDay && _endDate.isBefore(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('La date de fin doit être après la date de début')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(repositoryProvider);

      final event = EventsCompanion(
        title: drift.Value(_titleController.text),
        description: drift.Value(_descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null),
        startDate: drift.Value(_startDate),
        endDate: drift.Value(_endDate),
        location: drift.Value(_locationController.text.isNotEmpty
            ? _locationController.text
            : null),
        isAllDay: drift.Value(_isAllDay),
        createdAt: drift.Value(DateTime.now()),
      );

      final eventId = await repository.insertEvent(event);

      // Lier les contacts sélectionnés
      for (final contact in _selectedContacts) {
        await repository.linkEventToContact(eventId, contact.id);
      }

      // Force refresh of events provider
      ref.invalidate(eventsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Événement ajouté avec succès')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class _ContactSelectionDialog extends ConsumerWidget {
  final List<Contact> selectedContacts;

  const _ContactSelectionDialog({
    required this.selectedContacts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return AlertDialog(
      title: const Text('Sélectionner des contacts'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: contactsAsync.when(
          data: (contacts) {
            if (contacts.isEmpty) {
              return const Center(
                child: Text('Aucun contact disponible'),
              );
            }

            return StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    final isSelected = selectedContacts.contains(contact);

                    return CheckboxListTile(
                      title: Text(contact.fullName),
                      subtitle: Text(contact.displayTitle),
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedContacts.add(contact);
                          } else {
                            selectedContacts.remove(contact);
                          }
                        });
                      },
                    );
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Erreur: $error')),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(selectedContacts),
          child: const Text('Valider'),
        ),
      ],
    );
  }
}
