import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tempo/core/providers/providers.dart';
import 'package:tempo/core/database/database.dart';
import 'package:tempo/features/articles/presentation/widgets/tag_selector.dart';
import 'package:tempo/features/articles/presentation/widgets/file_picker_widget.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:io';

class AddArticlePage extends ConsumerStatefulWidget {
  const AddArticlePage({super.key});

  @override
  ConsumerState<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends ConsumerState<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _sourceController = TextEditingController();
  final _urlController = TextEditingController();
  final _summaryController = TextEditingController();

  bool _isLocal = true;
  bool _isLoading = false;
  List<String> _selectedTags = [];
  File? _selectedFile;

  @override
  void dispose() {
    _titleController.dispose();
    _sourceController.dispose();
    _urlController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvel article'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveArticle,
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
              // Type d'article
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type d\'article',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Article local'),
                              subtitle:
                                  const Text('Contenu saisi manuellement'),
                              value: true,
                              groupValue: _isLocal,
                              onChanged: (value) {
                                setState(() {
                                  _isLocal = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Lien externe'),
                              subtitle: const Text('Article LinkedIn, web...'),
                              value: false,
                              groupValue: _isLocal,
                              onChanged: (value) {
                                setState(() {
                                  _isLocal = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Titre
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre *',
                  hintText: 'Titre de l\'article',
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

              // Source
              TextFormField(
                controller: _sourceController,
                decoration: const InputDecoration(
                  labelText: 'Source *',
                  hintText: 'LinkedIn, Medium, Blog...',
                  prefixIcon: Icon(Icons.source),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La source est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // URL (si lien externe) ou Fichier (si article local)
              if (!_isLocal) ...[
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL *',
                    hintText: 'https://...',
                    prefixIcon: Icon(Icons.link),
                  ),
                  validator: (value) {
                    if (!_isLocal && (value == null || value.isEmpty)) {
                      return 'L\'URL est obligatoire pour un lien externe';
                    }
                    if (value != null && value.isNotEmpty) {
                      try {
                        Uri.parse(value);
                      } catch (e) {
                        return 'URL invalide';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ] else ...[
                // Import de fichier pour article local
                FilePickerWidget(
                  selectedFile: _selectedFile,
                  onFileChanged: (file) {
                    setState(() {
                      _selectedFile = file;
                    });
                  },
                  hintText: 'Sélectionnez un fichier PDF, Word, ou TXT...',
                  allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'rtf'],
                ),
                const SizedBox(height: 16),
              ],

              // Résumé
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(
                  labelText: 'Résumé',
                  hintText: 'Résumé de l\'article...',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Tags et mots-clés
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.tag,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Mots-clés et tags',
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
                        'Ajoutez des mots-clés pour faciliter la recherche et l\'organisation de vos articles.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 16),
                      TagSelector(
                        selectedTags: _selectedTags,
                        onTagsChanged: (tags) {
                          setState(() {
                            _selectedTags = tags;
                          });
                        },
                        hintText:
                            'Ex: Droit, LinkedIn, Management, Innovation...',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Boutons d'action
              Row(
                children: [
                  if (!_isLocal && _urlController.text.isNotEmpty) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _previewUrl,
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Prévisualiser'),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _saveArticle,
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

  Future<void> _previewUrl() async {
    final url = _urlController.text;
    if (url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impossible d\'ouvrir l\'URL')),
          );
        }
      }
    }
  }

  Future<void> _saveArticle() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(repositoryProvider);

      final article = ArticlesCompanion(
        title: drift.Value(_titleController.text),
        source: drift.Value(_sourceController.text),
        url: drift.Value(_isLocal
            ? (_selectedFile?.path)
            : (_urlController.text.isNotEmpty ? _urlController.text : null)),
        summary: drift.Value(_summaryController.text.isNotEmpty
            ? _summaryController.text
            : null),
        tags: drift.Value(
            _selectedTags.isNotEmpty ? _selectedTags.join(', ') : null),
        isLocal: drift.Value(_isLocal),
        date: drift.Value(DateTime.now()),
      );

      await repository.insertArticle(article);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Article ajouté avec succès')),
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
