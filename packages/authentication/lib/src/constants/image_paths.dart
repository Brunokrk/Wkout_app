class AuthenticationImagePaths {
  // Diretório base dos assets
  static const String _basePath = 'packages/authentication/assets/images';

  // Imagens SVG
  static const String logoSVG = '$_basePath/svg/logo.svg';
  static const String logoPNG = '$_basePath/png/logo.png';

  // Imagens PNG
  static const String genericAvatar = '$_basePath/png/generic_avatar.png';

  // Método para obter caminho completo
  static String getSvgPath(String fileName) => '$_basePath/svg/$fileName.svg';
  static String getPngPath(String fileName) => '$_basePath/png/$fileName.png';
}
