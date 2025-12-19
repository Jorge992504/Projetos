import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/custom_button.dart';
import 'package:servicespro/src/widgets/custom_text_field.dart';

class ClientPerfilScreen extends StatefulWidget {
  const ClientPerfilScreen({super.key});

  @override
  State<ClientPerfilScreen> createState() => _ClientPerfilScreenState();
}

class _ClientPerfilScreenState extends State<ClientPerfilScreen> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Dados')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorsConstants.secundaryColor,
                    maxRadius: 60,
                    // backgroundImage: fotoSelecionada != null
                    //     ? FileImage(fotoSelecionada!)
                    //     : null,
                    // child: fotoSelecionada == null
                    //     ? Image.network(
                    //         empresaModel.foto ?? "",
                    //         width: 80,
                    //         height: 80,
                    //       )
                    //     : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // escolherImagem(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: ColorsConstants.azulColor,
                        radius: 18,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomTextField(
                isDark: isDark,
                label: "Nome",
                textAlign: TextAlign.left,
                prefixIcon: Icon(Icons.person_outline_sharp),
                enabled: isEdit,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                isDark: isDark,
                label: "E-mail",
                textAlign: TextAlign.left,
                prefixIcon: Icon(Icons.email_outlined),
                enabled: isEdit,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                isDark: isDark,
                label: "Telefone",
                textAlign: TextAlign.left,
                prefixIcon: Icon(Icons.phone_android_rounded),
                enabled: isEdit,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                isDark: isDark,
                label: "Endereço",
                textAlign: TextAlign.left,
                prefixIcon: Icon(Icons.location_on_outlined),
                enabled: isEdit,
              ),
              const SizedBox(height: 100),
              Visibility(
                visible: !isEdit,
                child: CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isEdit = true;
                      });
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
              ),

              Visibility(
                visible: isEdit,
                child: CustomButton(
                  label: "Salvar alterações",
                  onPressed: () {
                    setState(() {
                      isEdit = false;
                    });
                  },
                  width: context.percentWidth(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
