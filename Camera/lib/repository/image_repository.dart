import 'dart:io';

import 'package:camera/database/banco_dados.dart';
import 'package:camera/models/image_model.dart';
import 'package:camera/services/api_service.dart';
import 'package:camera/services/conexao_service.dart';

Future<void> salvarOuEnviarImagem(File imagem) async {
  final bool temInternet = await verificarConexao();

  if (temInternet) {
    await enviarParaApi(imagem);
  } else {
    final imagemModelo = ImagemModelo(
      caminho: imagem.path,
      dataHora: DateTime.now().toIso8601String(),
    );
    await BancoDados().salvarImagem(imagemModelo);
  }
}
