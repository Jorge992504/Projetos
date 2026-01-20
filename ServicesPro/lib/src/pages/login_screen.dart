import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/base/base_state.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/login_controller.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/states/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginController> {
  final formKey = GlobalKey<FormState>();
  bool oscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginController, LoginState>(
        listener: (context, state) async {
          switch (state) {
            case LoginLoading():
              showLoader();
              break;

            case LoginFailure(:final errorMessage):
              hideLoader();
              showError(
                errorMessage!.isNotEmpty
                    ? errorMessage
                    : 'Login ou senha inválidos',
              );
              break;

            case LoginSuccess():
              hideLoader();
              showSuccess('Sucesso ao realizar login');
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).salvarToken(state.token);

              Provider.of<WebSocketProvider>(context, listen: false).conectar();

              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).salvarDadosUsuario();
              await buscarDadosUsuario();
              break;

            case LoginInitial():
              hideLoader();
              break;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        'Bem-vindo de volta!',
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
                        'Entre para continuar conectando-se com profissionais.',
                        style: context.cusotomFontes.regular.copyWith(
                          color: TemaSistema().temaSistema(context)
                              ? ColorsConstants.primaryColor
                              : ColorsConstants.letrasColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 16,
                          ),
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
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            passwordFocus.requestFocus();
                          } else {
                            emailFocus.requestFocus();
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: context.cusotomFontes.regular.copyWith(
                            color: TemaSistema().temaSistema(context)
                                ? ColorsConstants.primaryColor
                                : ColorsConstants.letrasColor,
                            fontSize: 16,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                oscureText = !oscureText;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
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
                        obscureText: oscureText,

                        cursorHeight: 18,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        focusNode: passwordFocus,
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            realizarLogin();
                          } else {
                            passwordFocus.requestFocus();
                          }
                        },
                      ),
                      // const SizedBox(height: 14),
                      // Form(
                      //   key: formKey,
                      //   child: Column(
                      //     children: [

                      //     ],
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(Rotas.receberCodigo);
                          },
                          child: Text(
                            'Esqueci minha senha',
                            style: context.cusotomFontes.medium.copyWith(
                              color: TemaSistema().temaSistema(context)
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.letrasColor,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      // Expanded(child: const SizedBox(height: 24)),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await realizarLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConstants.azulColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Entrar',
                            style: context.cusotomFontes.black.copyWith(
                              color: ColorsConstants.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: TemaSistema().temaSistema(context)
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.letrasColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'ou',
                              style: context.cusotomFontes.regular.copyWith(
                                color: TemaSistema().temaSistema(context)
                                    ? ColorsConstants.primaryColor
                                    : ColorsConstants.letrasColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: TemaSistema().temaSistema(context)
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.letrasColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Rotas.register);
                            },
                            child: Text(
                              'Não tem uma conta? Registre-se',
                              style: context.cusotomFontes.medium.copyWith(
                                color: TemaSistema().temaSistema(context)
                                    ? ColorsConstants.primaryColor
                                    : ColorsConstants.letrasColor,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> realizarLogin() async {
    if (emailController.text.isEmpty) {
      showError("E-mail obrigatorio");
      emailFocus.requestFocus();
      return;
    }
    if (passwordController.text.isEmpty) {
      showError("Senha obrigatoria");
      passwordFocus.requestFocus();
      return;
    }
    await controller.login(emailController.text, passwordController.text);
  }

  Future<void> buscarDadosUsuario() async {
    UsuarioModel usuarioModel = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).usuarioModel;

    if (usuarioModel.tipoUsuario == "Cliente") {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).salvarDadosUsuario();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Rotas.clientHome);
      }
    } else if (usuarioModel.tipoUsuario == "Prestador") {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).salvarDadosUsuario();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Rotas.employeeHome);
      }
    }
  }
}
