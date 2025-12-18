import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/escolher_foto.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/adiiconar_foto_finalizar_servico.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/avaliacao_client_employee.dart';
import 'package:servicespro/src/widgets/custom_button.dart';

class FinalizarServicoScreen extends StatefulWidget {
  const FinalizarServicoScreen({super.key});

  @override
  State<FinalizarServicoScreen> createState() => _FinalizarServicoScreenState();
}

class _FinalizarServicoScreenState extends State<FinalizarServicoScreen> {
  String userType = "cliente";
  int avaliacaoClientEmplo = 0;
  final ImagePicker _picker = ImagePicker();

  final List<File?> fotos = List.generate(4, (_) => null);

  Future<void> _pickImage(int index, ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (file != null) {
      setState(() {
        fotos[index] = File(file.path);
      });
    }
  }

  void _onAddPhoto(int index) {
    EscolherFoto().showPhotoSourceSheet(
      context,
      onCamera: () {
        Navigator.pop(context);
        _pickImage(index, ImageSource.camera);
      },
      onGallery: () {
        Navigator.pop(context);
        _pickImage(index, ImageSource.gallery);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Serviço'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fotos do Trabalho",
                style: context.cusotomFontes.black.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 14),
              Text("Adicione fotos do serviço realizado(não obrigatorio)"),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),

                itemCount: 4,
                itemBuilder: (context, index) {
                  return AdiiconarFotoFinalizarServico(
                    isDark: isDark,
                    image: fotos[index],
                    onTap: () => _onAddPhoto(index),
                  );
                },
              ),
              const SizedBox(height: 14),
              Text(
                userType != "cliente"
                    ? "Observações para o Cliente"
                    : "Informações para o Prestador",
                style: context.cusotomFontes.bold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Container(
                width: context.percentWidth(1),
                height: 200,

                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).colorScheme.surface
                      : ColorsConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: null, // permite infinitas linhas
                  minLines: 7, // começa com 3 linhas
                  keyboardType: TextInputType.multiline,
                  textAlignVertical:
                      TextAlignVertical.top, // melhor para multiline
                  cursorHeight: 18,
                  decoration: const InputDecoration(
                    hintText:
                        'Sugestões ou elogios sobre o troto e o trabalho realizado pelo prestador.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                userType != "cliente"
                    ? "Avaliação do Cliente"
                    : "Avaliação do Prestador",
                style: context.cusotomFontes.bold.copyWith(fontSize: 18),
              ),
              AvaliacaoClientEmployee(
                rating: avaliacaoClientEmplo,
                onRatingChanged: (value) {
                  setState(() {
                    avaliacaoClientEmplo = value;
                  });
                },
                activeColor: ServiceColors.reformaConstrucao,
                inactiveColor: ServiceColors.servicosAdministrativos,
                size: 40,
              ),
              const SizedBox(height: 14),
              CustomButton(
                label: "Finalizar",
                width: context.percentWidth(1),
                style: context.cusotomFontes.bold.copyWith(
                  color: ColorsConstants.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Rotas.clientHistoricoServico,
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
