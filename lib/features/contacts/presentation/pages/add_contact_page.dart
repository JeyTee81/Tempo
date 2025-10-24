import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/features/contacts/presentation/widgets/image_picker_widget.dart';
import 'dart:io';

class AddContactPage extends ConsumerStatefulWidget {
  const AddContactPage({super.key});

  @override
  ConsumerState<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends ConsumerState<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isLoading = false;
  File? _selectedImage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _jobTitleController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau contact'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveContact,
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
              // Photo de profil
              _buildPhotoSection(),
              const SizedBox(height: 24),

              // Informations personnelles
              _buildSection(
                title: 'Informations personnelles',
                icon: Icons.person,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'Prénom *',
                            hintText: 'Jean',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le prénom est obligatoire';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom *',
                            hintText: 'Dupont',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le nom est obligatoire';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Informations professionnelles
              _buildSection(
                title: 'Informations professionnelles',
                icon: Icons.business,
                children: [
                  TextFormField(
                    controller: _companyController,
                    decoration: const InputDecoration(
                      labelText: 'Entreprise',
                      hintText: 'Nom de l\'entreprise',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jobTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Poste',
                      hintText: 'Développeur, Manager...',
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Coordonnées
              _buildSection(
                title: 'Coordonnées',
                icon: Icons.contact_phone,
                children: [
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone',
                      hintText: '+33 6 12 34 56 78',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'jean.dupont@email.com',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Format d\'email invalide';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Notes
              _buildSection(
                title: 'Notes',
                icon: Icons.note,
                children: [
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Informations supplémentaires...',
                      prefixIcon: Icon(Icons.note_outlined),
                    ),
                    maxLines: 3,
                  ),
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
                      onPressed: _isLoading ? null : _saveContact,
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

  Widget _buildPhotoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.photo_camera,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Photo de profil',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ImagePickerWidget(
              selectedImage: _selectedImage,
              onImageChanged: (image) {
                setState(() {
                  _selectedImage = image;
                });
              },
              hintText: 'Cliquez pour sélectionner une photo',
            ),
          ],
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

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _companyController.clear();
    _jobTitleController.clear();
    _phoneController.clear();
    _emailController.clear();
    _notesController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(repositoryProvider);

      final contact = ContactsCompanion(
        firstName: drift.Value(_firstNameController.text),
        lastName: drift.Value(_lastNameController.text),
        company: drift.Value(_companyController.text.isNotEmpty
            ? _companyController.text
            : null),
        jobTitle: drift.Value(_jobTitleController.text.isNotEmpty
            ? _jobTitleController.text
            : null),
        phone: drift.Value(
            _phoneController.text.isNotEmpty ? _phoneController.text : null),
        email: drift.Value(
            _emailController.text.isNotEmpty ? _emailController.text : null),
        notes: drift.Value(
            _notesController.text.isNotEmpty ? _notesController.text : null),
        photoUrl: drift.Value(_selectedImage?.path),
        createdAt: drift.Value(DateTime.now()),
      );

      await repository.insertContact(contact);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact ajouté avec succès')),
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
