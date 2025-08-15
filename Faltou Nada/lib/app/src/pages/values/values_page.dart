import 'dart:io';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart' hide MemoryImage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ValuesPage extends StatefulWidget {
  const ValuesPage({super.key});

  @override
  State<ValuesPage> createState() => _ValuesPageState();
}

class _ValuesPageState extends State<ValuesPage> {
  File? fotoTirada;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorsConstants.fundoCard),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Faltou nada né',
              style: context.fontesLetras.textThin.copyWith(
                fontSize: 20,
                color: ColorsConstants.fundoCard,
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(
                ImageConstants.piscada16,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: abrirCamera, child: const Text("Abrir Câmera")),
            const SizedBox(height: 20),
            fotoTirada != null
                ? Column(
                    children: [
                      Image.file(fotoTirada!, height: 300),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Enviar PDF"),
                      ),
                    ],
                  )
                : const Text("Nenhuma foto tirada"),
          ],
        ),
      ),
    );
  }

  //abre a camera e salva a foto
  Future<void> abrirCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        fotoTirada = File(image.path);
      });
    }
  }

  //converter foto em pdf
  Future<File> coverteFoto(File foto) async {
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

  Future<void> enviarPdf() async {
    if (fotoTirada == null) return;
  }
}
