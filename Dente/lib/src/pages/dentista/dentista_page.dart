import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class DentistaPage extends StatefulWidget {
  const DentistaPage({super.key});

  @override
  State<DentistaPage> createState() => _DentistaPageState();
}

class _DentistaPageState extends State<DentistaPage> {
  final emailController = TextEditingController();
  final nmController = TextEditingController();
  final croController = TextEditingController();

  final telefoneController = TextEditingController();

  final emailFocus = FocusNode();
  final nmFocus = FocusNode();
  final croFocus = FocusNode();

  final telefoneFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar dentistas')),
      body: Align(
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 60,
                child: TextFormField(
                  cursorColor: ColorsConstants.appBarColor,
                  decoration: InputDecoration(
                    labelText: "Nome do dentista",
                    hintText: "Informe o nome do dentista",
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required("Nome obrigatorio"),
                  ]),
                  controller: nmController,
                  focusNode: nmFocus,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    emailFocus.requestFocus();
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 60,
                child: TextFormField(
                  cursorColor: ColorsConstants.appBarColor,
                  decoration: InputDecoration(
                    labelText: "E-mail do dentista",
                    hintText: "Informe o e-mail do dentista",
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required("E-mail obrigatorio"),
                    Validatorless.email("Informe um e-mail valido"),
                  ]),
                  controller: emailController,
                  focusNode: emailFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    croFocus.requestFocus();
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 60,
                child: TextFormField(
                  cursorColor: ColorsConstants.appBarColor,
                  decoration: InputDecoration(
                    labelText: "CRO do dentista",
                    hintText: "Informe o CRO do dentista",
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required("CRO obrigatorio"),
                  ]),
                  controller: croController,
                  focusNode: croFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    telefoneFocus.requestFocus();
                  },
                ),
              ),

              Container(
                alignment: Alignment.center,
                width: 400,
                height: 60,
                child: TextFormField(
                  cursorColor: ColorsConstants.appBarColor,
                  decoration: InputDecoration(
                    labelText: "Telefone do dentista",
                    hintText: "Informe o telefone do dentista",
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required("Telefone obrigatorio"),
                  ]),
                  controller: telefoneController,
                  focusNode: telefoneFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  inputFormatters: [celularFormatter],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                width: 900,
                child: ElevatedButton(
                  onPressed: () async {
                    // await registrarEmpresa();
                  },
                  child: Text(
                    'Salvar dados',
                    style: context.cusotomFontes.textItalic.copyWith(
                      color: ColorsConstants.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //! formata numero telefone
  final celularFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
