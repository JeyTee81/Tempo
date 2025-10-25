import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/core/models/contact.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ContactDetailPage extends ConsumerWidget {
  final int contactId;

  const ContactDetailPage({
    super.key,
    required this.contactId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactAsync = ref.watch(contactByIdProvider(contactId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du contact'),
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
            onPressed: () => _deleteContact(context, ref),
          ),
        ],
      ),
      body: contactAsync.when(
        data: (contact) {
          if (contact == null) {
            return const Center(
              child: Text('Contact non trouvé'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec photo
                _buildHeader(context, contact),
                const SizedBox(height: 24),

                // Informations personnelles
                _buildInfoSection(
                  context,
                  title: 'Informations personnelles',
                  icon: Icons.person,
                  items: [
                    _InfoItem(
                      label: 'Nom complet',
                      value: contact.fullName,
                      icon: Icons.person_outline,
                    ),
                    if (contact.company != null && contact.company!.isNotEmpty)
                      _InfoItem(
                        label: 'Entreprise',
                        value: contact.company!,
                        icon: Icons.business,
                      ),
                    if (contact.jobTitle != null &&
                        contact.jobTitle!.isNotEmpty)
                      _InfoItem(
                        label: 'Poste',
                        value: contact.jobTitle!,
                        icon: Icons.work,
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Coordonnées
                _buildInfoSection(
                  context,
                  title: 'Coordonnées',
                  icon: Icons.contact_phone,
                  items: [
                    if (contact.phone != null && contact.phone!.isNotEmpty)
                      _InfoItem(
                        label: 'Téléphone',
                        value: contact.phone!,
                        icon: Icons.phone,
                        isPhone: true,
                      ),
                    if (contact.email != null && contact.email!.isNotEmpty)
                      _InfoItem(
                        label: 'Email',
                        value: contact.email!,
                        icon: Icons.email,
                        isEmail: true,
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Notes
                if (contact.notes != null && contact.notes!.isNotEmpty) ...[
                  _buildInfoSection(
                    context,
                    title: 'Notes',
                    icon: Icons.note,
                    items: [
                      _InfoItem(
                        label: 'Informations',
                        value: contact.notes!,
                        icon: Icons.note_outlined,
                        isMultiline: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // Actions rapides
                _buildQuickActions(context, contact),
                const SizedBox(height: 16),

                // Informations techniques
                _buildInfoSection(
                  context,
                  title: 'Informations',
                  icon: Icons.info,
                  items: [
                    _InfoItem(
                      label: 'Date de création',
                      value: DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR')
                          .format(contact.createdAt),
                      icon: Icons.calendar_today,
                    ),
                    _InfoItem(
                      label: 'ID',
                      value: contact.id.toString(),
                      icon: Icons.tag,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Erreur: $error'),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Contact contact) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              backgroundImage:
                  contact.photoUrl != null && contact.photoUrl!.isNotEmpty
                      ? FileImage(File(contact.photoUrl!))
                      : null,
              child: contact.photoUrl != null && contact.photoUrl!.isNotEmpty
                  ? null
                  : Icon(
                      Icons.person,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.fullName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (contact.jobTitle != null &&
                      contact.jobTitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      contact.jobTitle!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                  if (contact.company != null &&
                      contact.company!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      contact.company!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<_InfoItem> items,
  }) {
    if (items.isEmpty) return const SizedBox.shrink();

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
            const SizedBox(height: 12),
            ...items.map((item) => _buildInfoItem(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, _InfoItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: () => _handleItemTap(context, item),
                  child: Text(
                    item.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: item.isPhone || item.isEmail
                              ? Theme.of(context).colorScheme.primary
                              : null,
                          decoration: item.isPhone || item.isEmail
                              ? TextDecoration.underline
                              : null,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, Contact contact) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flash_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Actions rapides',
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
              children: [
                if (contact.phone != null && contact.phone!.isNotEmpty)
                  ActionChip(
                    avatar: const Icon(Icons.phone, size: 18),
                    label: const Text('Appeler'),
                    onPressed: () => _makePhoneCall(contact.phone!),
                  ),
                if (contact.email != null && contact.email!.isNotEmpty)
                  ActionChip(
                    avatar: const Icon(Icons.email, size: 18),
                    label: const Text('Envoyer email'),
                    onPressed: () => _sendEmail(contact.email!),
                  ),
                ActionChip(
                  avatar: const Icon(Icons.event, size: 18),
                  label: const Text('Créer événement'),
                  onPressed: () {
                    // TODO: Navigate to create event with this contact
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Création d\'événement - À implémenter')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemTap(BuildContext context, _InfoItem item) {
    if (item.isPhone) {
      _makePhoneCall(item.value);
    } else if (item.isEmail) {
      _sendEmail(item.value);
    }
  }

  Future<void> _makePhoneCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _deleteContact(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le contact'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce contact ?'),
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
        await repository.deleteContact(contactId);

        // Force refresh of contacts provider
        ref.invalidate(contactsProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact supprimé')),
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

class _InfoItem {
  final String label;
  final String value;
  final IconData icon;
  final bool isPhone;
  final bool isEmail;
  final bool isMultiline;

  const _InfoItem({
    required this.label,
    required this.value,
    required this.icon,
    this.isPhone = false,
    this.isEmail = false,
    this.isMultiline = false,
  });
}
