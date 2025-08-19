import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dio/dio.dart';

void main() {
  runApp(AppPrincipal());
}

/// AppPrincipal: widget principal do aplicativo
class AppPrincipal extends StatelessWidget {
  const AppPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envio de Foto como PDF',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaCamera(),
    );
  }
}

/// TelaCamera: tela que controla a câmera, exibe a foto e envia para a API
class TelaCamera extends StatefulWidget {
  const TelaCamera({super.key});

  @override
  State<TelaCamera> createState() => _TelaCameraState();
}

class _TelaCameraState extends State<TelaCamera> {
  File? fotoTirada; // Armazena a foto tirada

  final ImagePicker _picker = ImagePicker();

  /// abrirCamera: abre a câmera e salva a foto no estado
  Future<void> abrirCamera() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.camera);
    if (imagem != null) {
      setState(() {
        fotoTirada = File(imagem.path);
      });
    }
  }

  /// criarPdfDaFoto: converte a foto tirada em PDF e retorna o arquivo PDF
  Future<File> criarPdfDaFoto(File foto) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(await foto.readAsBytes());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(image));
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final arquivoPdf = File('${dir.path}/nf_imagem.pdf');
    await arquivoPdf.writeAsBytes(await pdf.save());
    return arquivoPdf;
  }

  /// enviarPdfParaApi: envia o PDF gerado para a API usando Dio
  Future<void> enviarPdfParaApi() async {
    if (fotoTirada == null) return;

    File pdf = await criarPdfDaFoto(fotoTirada!);

    // final Dio dioUnauth = Dio(
    //   BaseOptions(baseUrl: 'http://172.16.251.22:8082/api'),
    // );
    final dio = Dio();
    dio.options.headers = {
      'Content-Type': 'multipart/form-data', // se estiver enviando arquivo
    };
    final formData = FormData.fromMap({
      "arquivo": await MultipartFile.fromFile(pdf.path, filename: "nf.pdf"),
    });

    try {
      await dio.post("http://172.16.251.22:8082/api/nfe", data: formData);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("PDF enviado com sucesso!")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao enviar PDF: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Envio de Foto como PDF")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: abrirCamera, child: Text("Abrir Câmera")),
            SizedBox(height: 20),
            fotoTirada != null
                ? Column(
                    children: [
                      Image.file(fotoTirada!, height: 300),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: enviarPdfParaApi,
                        child: Text("Enviar PDF"),
                      ),
                    ],
                  )
                : Text("Nenhuma foto tirada"),
          ],
        ),
      ),
    );
  }
}
