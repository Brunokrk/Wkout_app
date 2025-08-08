import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  /// Seleciona uma imagem da galeria
  static Future<Uint8List?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        return await imageFile.readAsBytes();
      }
      return null;
    } catch (e) {
      debugPrint('Erro ao selecionar imagem da galeria: $e');
      return null;
    }
  }

  /// Tira uma foto com a câmera
  static Future<Uint8List?> takePhotoWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        return await imageFile.readAsBytes();
      }
      return null;
    } catch (e) {
      debugPrint('Erro ao tirar foto: $e');
      return null;
    }
  }

  /// Mostra um modal para escolher entre galeria ou câmera
  static Future<Uint8List?> showImageSourceDialog(BuildContext context) async {
    return showDialog<Uint8List?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecionar Foto'),
          content: const Text('Escolha como deseja adicionar sua foto de perfil:'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final imageBytes = await pickImageFromGallery();
                if (imageBytes != null) {
                  Navigator.of(context).pop(imageBytes);
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('Galeria'),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final imageBytes = await takePhotoWithCamera();
                if (imageBytes != null) {
                  Navigator.of(context).pop(imageBytes);
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Câmera'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
} 