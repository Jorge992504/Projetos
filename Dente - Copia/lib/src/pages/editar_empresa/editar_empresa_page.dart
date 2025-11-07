import 'dart:convert';
import 'dart:io';

import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_controller.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_state.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class EditarEmpresaPage extends StatefulWidget {
  const EditarEmpresaPage({super.key});

  @override
  State<EditarEmpresaPage> createState() => _EditarEmpresaPageState();
}

class _EditarEmpresaPageState
    extends BaseState<EditarEmpresaPage, EditarEmpresaController> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nomeClinicaController;
  late TextEditingController cnpjClinicaController;
  late TextEditingController emailController;
  late TextEditingController telefoneController;
  late TextEditingController enderecoController;
  final nomeFocus = FocusNode();
  final cnpjFocus = FocusNode();
  final emailFocus = FocusNode();
  final enderecoFocus = FocusNode();
  final telefoneFocus = FocusNode();

  late EmpresaModel empresaModel;

  bool obscureText = true;
  bool obscure2Text = true;

  File? fotoSelecionada;
  String? fotoBase64;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    empresaModel = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).empresaModel;
    nomeClinicaController = TextEditingController(
      text: empresaModel.nomeClinica,
    );
    cnpjClinicaController = TextEditingController(text: empresaModel.cnpj);
    emailController = TextEditingController(text: empresaModel.emailClinica);
    telefoneController = TextEditingController(text: empresaModel.telefone);
    enderecoController = TextEditingController(text: empresaModel.endereco);
  }

  @override
  void dispose() {
    nomeFocus.dispose();
    cnpjFocus.dispose();
    emailFocus.dispose();
    enderecoFocus.dispose();
    telefoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar dados da clinica')),
      body: BlocConsumer<EditarEmpresaController, EditarEmpresaState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
              hideLoader();
            },
            success: () async {
              hideLoader();
              showSuccess("Sucesso ao realizar cadastro.");
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).atualizarUsuario();
            },
          );
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, tamanho) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: tamanho.maxWidth * 1, height: 14),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorsConstants.focusColor,
                            maxRadius: 50,
                            backgroundImage: fotoSelecionada != null
                                ? FileImage(fotoSelecionada!)
                                : null,
                            child: fotoSelecionada == null
                                ? Image.network(
                                    empresaModel.foto ?? "",
                                    width: 80,
                                    height: 80,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                escolherImagem(context);
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
                            labelText: "CNPJ",
                            hintText: "Digite o CNPJ",
                            counterText: "",
                          ),
                          validator: Validatorless.required(
                            " Informe o CNPJ da clinica",
                          ),
                          controller: cnpjClinicaController,
                          focusNode: cnpjFocus,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [cnpjFormatter],
                          maxLength: 18,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: tamanho.maxWidth * 0.3,
                        child: TextFormField(
                          cursorColor: ColorsConstants.appBarColor,
                          decoration: InputDecoration(
                            labelText: "Endereço",
                            hintText: "Digite o endereço",
                          ),
                          validator: Validatorless.required(
                            "Informe o endereço da clinica",
                          ),
                          controller: enderecoController,
                          focusNode: enderecoFocus,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: tamanho.maxWidth * 0.3,
                        child: TextFormField(
                          cursorColor: ColorsConstants.appBarColor,
                          decoration: InputDecoration(
                            labelText: "Telefone",
                            hintText: "Digite o telefone",
                          ),
                          validator: Validatorless.required(
                            "Informe o telefone da clinica",
                          ),
                          controller: telefoneController,
                          focusNode: telefoneFocus,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [celularFormatter],
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: tamanho.maxWidth * 0.3,
                        child: TextFormField(
                          cursorColor: ColorsConstants.appBarColor,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            hintText: "Digite o e-mail",
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required("E-mail obrigatorio"),
                            Validatorless.email("Informe um e-mail valido"),
                          ]),
                          controller: emailController,
                          focusNode: emailFocus,
                          textInputAction: TextInputAction.next,
                          enabled: false,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: tamanho.maxWidth * 0.2,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            await gravaEditarEmpresa();
                          },
                          child: Text(
                            'Salvar',
                            style: context.cusotomFontes.textBold.copyWith(
                              color: ColorsConstants.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> escolherImagem(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: ColorsConstants.appBarColor,
                ),
                title: Text(
                  'Galeria',
                  style: context.cusotomFontes.textItalic.copyWith(
                    color: ColorsConstants.letrasColor,
                  ),
                ),
                onTap: () async {
                  final XFile? imagem = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (imagem != null) {
                    final file = File(imagem.path);
                    final bytes = await file.readAsBytes();
                    setState(() {
                      fotoSelecionada = file; // para exibir na tela
                      fotoBase64 = base64Encode(
                        bytes,
                      ); // para enviar para a API
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final celularFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> gravaEditarEmpresa() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      EmpresaModel model = EmpresaModel(
        foto: fotoSelecionada == null ? empresaModel.foto : fotoBase64,
        nomeClinica: nomeClinicaController.text,
        cnpj: cnpjClinicaController.text,
        endereco: enderecoController.text,
        telefone: telefoneController.text,
      );
      await controller.gravaEditarEmpresa(model);
    }
  }
}
