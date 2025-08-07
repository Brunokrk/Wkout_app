import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;
  final Uint8List? imageBytes;
  final double size;
  final VoidCallback? onTap;
  final bool showEditIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final Widget? placeholder;
  final String? placeholderText;

  const CustomProfileImage({
    super.key,
    this.imageUrl,
    this.imagePath,
    this.imageBytes,
    this.size = 120,
    this.onTap,
    this.showEditIcon = true,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2,
    this.placeholder,
    this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Container principal da imagem
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor ?? AppColors.grey,
              border: Border.all(
                color: borderColor ?? AppColors.primary,
                width: borderWidth,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: _buildImageWidget(),
            ),
          ),
          // Ícone de edição
          if (showEditIcon && onTap != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    // Se há bytes de imagem (mais comum para imagens selecionadas)
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      return Image.memory(
        imageBytes!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Erro ao carregar imagem de bytes: $error');
          return _buildPlaceholder();
        },
      );
    }

    // Se há uma imagem local
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Erro ao carregar imagem local: $error');
          return _buildPlaceholder();
        },
      );
    }

    // Se há uma URL de imagem
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: AppColors.primary,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('Erro ao carregar imagem de URL: $error');
          return _buildPlaceholder();
        },
      );
    }

    // Debug: verificar quais parâmetros estão sendo passados
    print('CustomProfileImage - Debug:');
    print('  imageUrl: $imageUrl');
    print('  imagePath: $imagePath');
    print('  imageBytes: ${imageBytes?.length ?? 0} bytes');

    // Placeholder padrão
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    if (placeholder != null) {
      return placeholder!;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: size * 0.4,
            color: AppColors.blackText.withOpacity(0.5),
          ),
          if (placeholderText != null) ...[
            const SizedBox(height: 8),
            Text(
              placeholderText!,
              style: AppTypography.bodyText2.copyWith(
                color: AppColors.blackText.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
