import 'dart:io';
import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final Uint8List? imageBytes;
  final String? placeholderImagePath;
  final void Function(Uint8List?) onImageSelected;
  final bool showEditIcon;
  final Color? borderColor;
  final String? placeholderText;
  final double size;

  const ProfileImagePicker({
    super.key,
    required this.imageBytes,
    required this.onImageSelected,
    this.placeholderImagePath,
    this.showEditIcon = true,
    this.borderColor,
    this.placeholderText,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProfileImage(
      showEditIcon: showEditIcon,
      onTap: () => _showPickerSheet(context),
      imageBytes: imageBytes,
      imagePath: imageBytes == null ? placeholderImagePath : null,
      borderColor: borderColor,
      placeholderText: placeholderText,
      size: size,
    );
  }

  Future<void> _showPickerSheet(BuildContext context) async {
    // ignore: use_build_context_synchronously
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final bytes = await _pickImage(ImageSource.gallery);
                  if (bytes != null) {
                    onImageSelected(bytes);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final bytes = await _pickImage(ImageSource.camera);
                  if (bytes != null) {
                    onImageSelected(bytes);
                  }
                },
              ),
              if (imageBytes != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Remover foto'),
                  onTap: () {
                    Navigator.of(context).pop();
                    onImageSelected(null);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<Uint8List?> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image == null) return null;
      final file = File(image.path);
      return file.readAsBytes();
    } catch (_) {
      return null;
    }
  }
}

