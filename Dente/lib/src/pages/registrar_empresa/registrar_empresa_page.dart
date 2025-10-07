import 'dart:convert';
import 'dart:io';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_controller.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_state.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegistrarEmpresaPage extends StatefulWidget {
  const RegistrarEmpresaPage({super.key});

  @override
  State<RegistrarEmpresaPage> createState() => _RegistrarEmpresaPageState();
}

class _RegistrarEmpresaPageState
    extends BaseState<RegistrarEmpresaPage, RegistrarEmpresaController> {
  final formKey = GlobalKey<FormState>();
  final nomeClinicaController = TextEditingController();
  final cnpjClinicaController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();
  final nomeFocus = FocusNode();
  final cnpjFocus = FocusNode();
  final senhaFocus = FocusNode();
  final confirmaSenhaFocus = FocusNode();
  final emailFocus = FocusNode();
  final enderecoFocus = FocusNode();
  final telefoneFocus = FocusNode();

  bool obscureText = true;
  bool obscure2Text = true;

  File? fotoSelecionada;
  String? fotoBase64;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    nomeClinicaController.dispose();
    cnpjClinicaController.dispose();
    nomeFocus.dispose();
    cnpjFocus.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegistrarEmpresaController, RegistrarEmpresaState>(
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
              showSuccess("Sucesso");
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).atualizarUsuario();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(Rotas.home, (route) => false);
              });
              hideLoader();
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: tamanho.maxWidth * 1,
                        child: Text(
                          "Cadastro da Clinica",
                          style: context.cusotomFontes.textExtraBold.copyWith(
                            color: ColorsConstants.letrasColor,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorsConstants.focusColor,
                            maxRadius: 50,
                            backgroundImage: fotoSelecionada != null
                                ? FileImage(fotoSelecionada!)
                                : null,
                            child: fotoSelecionada == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
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
                            labelText: "CNPJ da clinica",
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
                            labelText: "Endereço da clinica",
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
                            labelText: "Telefone da clinica",
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
                            labelText: "E-mail da clinica",
                            hintText: "Digite o e-mail",
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.required("E-mail obrigatorio"),
                            Validatorless.email("Informe um e-mail valido"),
                          ]),
                          controller: emailController,
                          focusNode: emailFocus,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: tamanho.maxWidth * 0.3,
                        child: TextFormField(
                          cursorColor: ColorsConstants.appBarColor,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            hintText: "Digite a senha",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText == true
                                    ? Icons.password_outlined
                                    : Icons.remove_red_eye_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.min(
                              4,
                              'Senha deve ter minimo 4 cacteres',
                            ),
                            Validatorless.required("Senha obrigatoria"),
                          ]),
                          controller: senhaController,
                          focusNode: senhaFocus,
                          textInputAction: TextInputAction.next,
                          obscureText: obscureText,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: tamanho.maxWidth * 0.3,
                        child: TextFormField(
                          cursorColor: ColorsConstants.appBarColor,
                          decoration: InputDecoration(
                            labelText: "Confirma Senha",
                            hintText: "Digite sua senha novamente",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure2Text = !obscure2Text;
                                });
                              },
                              icon: Icon(
                                obscure2Text == true
                                    ? Icons.password_outlined
                                    : Icons.remove_red_eye_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                          validator: Validatorless.multiple([
                            Validatorless.compare(
                              senhaController,
                              "Senhas diferentes",
                            ),
                            Validatorless.required(
                              "Repeta sua senha obrigatoria",
                            ),
                          ]),
                          controller: confirmaSenhaController,
                          focusNode: confirmaSenhaFocus,
                          textInputAction: TextInputAction.done,
                          obscureText: obscure2Text,
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        width: tamanho.maxWidth * 0.3,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(Rotas.login);
                          },

                          child: Text(
                            "Já tenho cadastro",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(color: ColorsConstants.buttonColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: tamanho.maxWidth * 0.2,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            await registrarEmpresa();
                          },
                          child: Text(
                            'Continuar',
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

  // Future<void> escolherImagem(BuildContext context) async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(
  //                 Icons.photo_library,
  //                 color: ColorsConstants.appBarColor,
  //               ),
  //               title: Text(
  //                 'Galeria',
  //                 style: context.cusotomFontes.textItalic.copyWith(
  //                   color: ColorsConstants.letrasColor,
  //                 ),
  //               ),
  //               iconColor: ColorsConstants.appBarColor,
  //               onTap: () async {
  //                 final XFile? imagem = await _picker.pickImage(
  //                   source: ImageSource.gallery,
  //                 );
  //                 if (imagem != null) {
  //                   setState(() {
  //                     fotoSelecionada = File(imagem.path);
  //                   });
  //                 }
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             // ListTile(
  //             //   leading: const Icon(Icons.photo_camera),
  //             //   title: const Text('Câmera'),
  //             //   onTap: () async {
  //             //     final XFile? imagem = await _picker.pickImage(
  //             //       source: ImageSource.camera,
  //             //     );
  //             //     if (imagem != null) {
  //             //       setState(() {
  //             //         fotoSelecionada = File(imagem.path);
  //             //       });
  //             //     }
  //             //     Navigator.of(context).pop();
  //             //   },
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
              // ListTile para câmera, se quiser
              // ListTile(
              //   leading: const Icon(Icons.photo_camera),
              //   title: const Text('Câmera'),
              //   onTap: () async {
              //     final XFile? imagem = await _picker.pickImage(
              //       source: ImageSource.camera,
              //     );
              //     if (imagem != null) {
              //       final file = File(imagem.path);
              //       final bytes = await file.readAsBytes();
              //       setState(() {
              //         fotoSelecionada = file;
              //         fotoBase64 = base64Encode(bytes);
              //       });
              //     }
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<void> registrarEmpresa() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      EmpresaModel model = EmpresaModel(
        foto: fotoBase64,
        nomeClinica: nomeClinicaController.text,
        emailClinica: emailController.text,
        telefone: telefoneController.text,
        endereco: enderecoController.text,
        passowrd: senhaController.text,
        cnpj: cnpjClinicaController.text,
      );
      final token = await controller.register(model);
      if (token.isNotEmpty) {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).registrarEmpresa(emailController.text, token['token']);
      }
    }
  }

  final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final celularFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
