import 'package:flutter/material.dart';
import 'package:authentication/authentication.dart';

class ImageUsageExample extends StatelessWidget {
  const ImageUsageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de Uso de Imagens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Imagens SVG:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Usando constante predefinida
            AuthImageWidget(
              imagePath: AuthenticationImagePaths.logo,
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 16),

            // Usando método para gerar caminho
            AuthImageWidget(
              imagePath: AuthenticationImagePaths.getSvgPath('logo'),
              width: 80,
              height: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 32),

            const Text(
              'Imagens PNG:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Exemplo com PNG (quando o arquivo existir)
            AuthImageWidget(
              imagePath: AuthenticationImagePaths.userIcon,
              width: 60,
              height: 60,
            ),

            const SizedBox(height: 16),

            // Usando método para gerar caminho PNG
            AuthImageWidget(
              imagePath: AuthenticationImagePaths.getPngPath('background'),
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
