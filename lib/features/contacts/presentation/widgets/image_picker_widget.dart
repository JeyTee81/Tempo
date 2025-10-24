import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final File? selectedImage;
  final Function(File?) onImageChanged;
  final double radius;
  final String? hintText;

  const ImagePickerWidget({
    super.key,
    this.selectedImage,
    required this.onImageChanged,
    this.radius = 60,
    this.hintText,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: widget.radius,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                backgroundImage: widget.selectedImage != null
                    ? FileImage(widget.selectedImage!)
                    : null,
                child: widget.selectedImage == null
                    ? Icon(
                        Icons.person,
                        size: widget.radius,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton.small(
                  onPressed: _pickImage,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.photo_library, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.selectedImage == null
              ? (widget.hintText ?? 'Cliquez pour sélectionner une photo')
              : 'Photo sélectionnée',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        if (widget.selectedImage != null) ...[
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _removeImage,
            icon: const Icon(Icons.delete),
            label: const Text('Supprimer la photo'),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        widget.onImageChanged(file);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sélection: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage() {
    widget.onImageChanged(null);
  }
}
