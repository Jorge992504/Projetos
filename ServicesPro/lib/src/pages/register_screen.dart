import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/base/base_state.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/register_controller.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/states/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends BaseState<RegisterScreen, RegisterController> {
  final formKey = GlobalKey<FormState>();
  bool oscureTextSenha = true;
  bool oscureTextConfirmaSenha = true;
  bool habilitarBotao = false;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  final nomeFocus = FocusNode();
  final emailFocus = FocusNode();
  final senhaFocus = FocusNode();
  final confirmaSenhaFocus = FocusNode();

  File? fotoSelecionada;
  String? fotoBase64; //! foto para enviar
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterController, RegisterState>(
        listener: (context, state) async {
          switch (state) {
            case RegisterLoading():
              showLoader();
              break;

            case RegisterLoaded():
              showLoader();
              break;

            case RegisterFailure(:final errorMessage):
              hideLoader();
              showError(
                errorMessage!.isNotEmpty
                    ? errorMessage
                    : 'Login ou senha inválidos',
              );
              break;

            case RegisterSuccess():
              hideLoader();
              showSuccess('Cadastro realizado com sucesso');
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).salvarToken(state.token ?? '');

              if (state.token!.isNotEmpty) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Rotas.registerClientEmployee,
                  (route) => false,
                );
              }

              break;

            case RegisterInitial():
              hideLoader();
              break;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Criar conta.',
                      style: context.cusotomFontes.black.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Preencha seus dados para começar.',
                      style: context.cusotomFontes.regular.copyWith(
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: ColorsConstants.secundaryColor
                            // ignore: deprecated_member_use
                            .withOpacity(0.3),
                        backgroundImage: fotoSelecionada != null
                            ? FileImage(fotoSelecionada!)
                            : null,
                        radius: 50,
                        child: IconButton(
                          onPressed: () {
                            escolherImagem(context);
                          },
                          icon: fotoSelecionada == null
                              ? Icon(
                                  Icons.camera_enhance_outlined,
                                  color: ColorsConstants.secundaryColor,
                                  size: 40,
                                )
                              : Icon(
                                  Icons.camera_enhance_outlined,
                                  color: Colors.transparent,
                                  size: 40,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Adicionar foto de perfil (opcional)',
                        style: context.cusotomFontes.regular.copyWith(
                          color: ColorsConstants.secundaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nome completo',
                              labelStyle: context.cusotomFontes.regular
                                  .copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 16,
                                  ),
                              hintText: 'Digite seu nome completo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.telaColor
                                      : ColorsConstants.letrasColor,
                                  width: 2,
                                ),
                              ),
                            ),

                            cursorHeight: 18,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: nomeController,
                            focusNode: nomeFocus,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: context.cusotomFontes.regular
                                  .copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 16,
                                  ),
                              hintText: 'Digite seu e-mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.telaColor
                                      : ColorsConstants.letrasColor,
                                  width: 2,
                                ),
                              ),
                            ),

                            cursorHeight: 18,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            focusNode: emailFocus,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: context.cusotomFontes.regular
                                  .copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 16,
                                  ),
                              hintText: 'Digite sua senha',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    oscureTextSenha = !oscureTextSenha;
                                  });
                                },
                                icon: Icon(
                                  oscureTextSenha
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.primaryColor
                                      : ColorsConstants.letrasColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.telaColor
                                      : ColorsConstants.letrasColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            obscureText: oscureTextSenha,

                            cursorHeight: 18,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            controller: senhaController,
                            focusNode: senhaFocus,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirmar Senha',
                              labelStyle: context.cusotomFontes.regular
                                  .copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 16,
                                  ),
                              hintText: 'Digite sua senha novamente',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    oscureTextConfirmaSenha =
                                        !oscureTextConfirmaSenha;
                                  });
                                },
                                icon: Icon(
                                  oscureTextConfirmaSenha
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.primaryColor
                                      : ColorsConstants.letrasColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: TemaSistema().temaSistema(context)
                                      ? ColorsConstants.telaColor
                                      : ColorsConstants.letrasColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            obscureText: oscureTextConfirmaSenha,

                            cursorHeight: 18,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            controller: confirmarSenhaController,
                            focusNode: confirmaSenhaFocus,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Checkbox(
                                value: habilitarBotao,
                                onChanged: (value) {
                                  setState(() {
                                    habilitarBotao = value ?? false;
                                  });
                                },
                                activeColor: ColorsConstants.azulColor,
                                checkColor: ColorsConstants.letrasColor,
                              ),
                              Expanded(
                                child: Text(
                                  'Aceito os termos de uso e política de privacidade',
                                  style: context.cusotomFontes.regular.copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.primaryColor
                                        : ColorsConstants.letrasColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(Rotas.termosPolitica);
                                },
                                child: Text(
                                  'Termos de uso e\npolítica de privacidade',
                                  style: context.cusotomFontes.regular.copyWith(
                                    color: TemaSistema().temaSistema(context)
                                        ? ColorsConstants.secundaryColor
                                        : ColorsConstants.azulColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: habilitarBotao
                                  ? () async {
                                      if (formKey.currentState!.validate()) {
                                        await registrarUsuario();
                                      }
                                    }
                                  : null,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsConstants.secundaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Criar conta',
                                style: context.cusotomFontes.bold.copyWith(
                                  color: ColorsConstants.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> registrarUsuario() async {
    if (nomeController.text.isEmpty) {
      showError("Nome obrigatorio");
      emailFocus.requestFocus();
      return;
    }
    if (emailController.text.isEmpty) {
      showError("E-mail obrigatorio");
      emailFocus.requestFocus();
      return;
    }
    if (senhaController.text.isEmpty) {
      showError("Senha obrigatoria");
      senhaFocus.requestFocus();
      return;
    }
    if (confirmarSenhaController.text.isEmpty) {
      showError("Repita a senha");
      confirmaSenhaFocus.requestFocus();
      return;
    }
    if (senhaController.text != confirmarSenhaController.text) {
      showError("Senhas diferentes");
      confirmaSenhaFocus.requestFocus();
      return;
    }
    UsuarioModel usuarioModel = UsuarioModel(
      email: emailController.text,
      nome: nomeController.text,
      senha: senhaController.text,
      foto: fotoBase64,
      termosPolitica: habilitarBotao,
    );
    await controller.registrarUsuario(usuarioModel);
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
                  color: ColorsConstants.primaryColor,
                ),
                title: Text(
                  'Galeria',
                  style: context.cusotomFontes.extraLight.copyWith(
                    color: ColorsConstants.primaryColor,
                    fontSize: 14,
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
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  'Câmera',
                  style: context.cusotomFontes.extraLight.copyWith(
                    color: ColorsConstants.primaryColor,
                    fontSize: 14,
                  ),
                ),
                onTap: () async {
                  final XFile? imagem = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (imagem != null) {
                    final file = File(imagem.path);
                    final bytes = await file.readAsBytes();
                    setState(() {
                      fotoSelecionada = file;
                      fotoBase64 = base64Encode(bytes);
                    });
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
