import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const AuthImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        color: color,
        fit: fit ?? BoxFit.contain,
      );
    }
  }
}
