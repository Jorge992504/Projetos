import 'dart:io';

import 'package:camera/repository/image_repository.dart';
import 'package:camera/utils/seletor_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageSelecionada;

  Future<void> tirarFoto({required bool usarFrontal}) async {
    final ImagePicker seletor = ImagePicker();
    final camera = await obterCamera(usarFrontal: usarFrontal);
    final XFile? imagem = await seletor.pickImage(
        source: ImageSource.camera, preferredCameraDevice: camera);
    if (imagem != null) {
      final arquivoImage = File(imagem.path);
      setState(() {
        imageSelecionada = arquivoImage;
      });
      await salvarOuEnviarImagem(arquivoImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tirar Foto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Tirar com câmera traseira'),
              onPressed: () => tirarFoto(usarFrontal: false),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_front),
              label: const Text('Tirar com câmera frontal'),
              onPressed: () => tirarFoto(usarFrontal: true),
            ),
            const SizedBox(height: 24),
            if (imageSelecionada != null)
              CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(imageSelecionada!),
              ),
          ],
        ),
      ),
    );
  }
}
