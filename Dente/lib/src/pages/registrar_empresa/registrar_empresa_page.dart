import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class RegistrarEmpresaPage extends StatefulWidget {
  const RegistrarEmpresaPage({super.key});

  @override
  State<RegistrarEmpresaPage> createState() => _RegistrarEmpresaPageState();
}

class _RegistrarEmpresaPageState extends State<RegistrarEmpresaPage> {
  final formKey = GlobalKey<FormState>();
  final nomeClinicaController = TextEditingController();
  final cnpjClinicaController = TextEditingController();
  final nomeFocus = FocusNode();
  final cnpjFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    nomeClinicaController.dispose();
    cnpjClinicaController.dispose();
    nomeFocus.dispose();
    cnpjFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, tamanho) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 400),
                    child: Text(
                      "Cadastro da Clinica",
                      style: context.cusotomFontes.textExtraBold.copyWith(
                        color: ColorsConstants.letrasColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsConstants.focusColor,
                      maxRadius: 50,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // aqui você pode abrir a câmera ou galeria
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorsConstants.buttonColor,
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
                const SizedBox(height: 14),
                SizedBox(
                  width: tamanho.maxWidth * 0.3,
                  child: TextFormField(
                    cursorColor: ColorsConstants.appBarColor,
                    decoration: InputDecoration(
                      labelText: "Nome da clinica",
                      hintText: "Digite o nome",
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('Informe o nome da clinica'),
                    ]),
                    controller: nomeClinicaController,
                    focusNode: nomeFocus,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: tamanho.maxWidth * 0.3,
                  child: TextFormField(
                    cursorColor: ColorsConstants.appBarColor,
                    decoration: InputDecoration(
                      labelText: "CNPJ da clinica",
                      hintText: "Digite o CNPJ",
                    ),
                    validator: Validatorless.cnpj("Informe o CNPJ da clinica"),
                    controller: cnpjClinicaController,
                    focusNode: cnpjFocus,
                    textInputAction: TextInputAction.done,
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 285),
                  child: TextButton(
                    onPressed: () {},

                    child: Text(
                      "Já tenho cadastro",
                      style: context.cusotomFontes.textBoldItalic.copyWith(
                        color: ColorsConstants.buttonColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: tamanho.maxHeight * 0.2,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Contuniar',
                      style: context.cusotomFontes.textBold.copyWith(
                        color: ColorsConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
