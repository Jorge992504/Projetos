import 'dart:io';
import 'package:dio/dio.dart';

final Dio _dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:9003', // Altere para sua URL real da API
));

Future<void> enviarParaApi(File imagem) async {
  final nomeArquivo = imagem.path.split('/').last;

  final formData = FormData.fromMap({
    'arquivo': await MultipartFile.fromFile(imagem.path, filename: nomeArquivo),
  });

  try {
    final resposta = await _dio.post('/upload', data: formData);

    if (resposta.statusCode == 200) {
      print('Imagem enviada com sucesso!');
    } else {
      print('Erro ao enviar imagem: ${resposta.statusCode}');
    }
  } catch (e) {
    print('Erro ao enviar imagem: $e');
  }
}
