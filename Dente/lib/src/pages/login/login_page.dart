import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/pages/login/login_controller.dart';
import 'package:dente/src/pages/login/login_state.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final senhaFocus = FocusNode();
  final emailFocus = FocusNode();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    senhaFocus.dispose();
    emailFocus.dispose();
    senhaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginController, LoginState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              hideLoader();
              showError(state.errorMessage ?? 'Login ou senha inválidos');
            },
            sucess: () async {
              hideLoader(); // <- Primeiro esconde o loading
              showSuccess('Sucesso ao realizar login');
              await Provider.of<AuthProvider>(
                context,
                listen: false,
              ).atualizarUsuario();
              await validarPlano();
              // WidgetsBinding.instance.addPostFrameCallback((_) async {
              //   Navigator.of(
              //     // ignore: use_build_context_synchronously
              //     context,
              //   ).pushNamedAndRemoveUntil(Rotas.home, (route) => false);
              // });
            },
          );
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, tamanho) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: tamanho.maxWidth * 1,
                    child: Text(
                      "Login",
                      style: context.cusotomFontes.textExtraBold.copyWith(
                        color: ColorsConstants.letrasColor,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
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
                  Container(
                    alignment: Alignment.centerRight,
                    width: tamanho.maxWidth * 0.3,
                    child: TextButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          //chama a função q envia o email com o codigo para redefinir a senha
                          Navigator.of(context).pushNamed(
                            Rotas.resetPassword,
                            arguments: {"email": emailController.text},
                          );
                        } else {
                          showInfo("Informe o e-mail para redefinir a senha");
                          emailFocus.requestFocus();
                        }
                        // Navigator.of(context).popAndPushNamed(
                        //   Rotas.resetPassword,
                        //   arguments: {"email": emailController.text},
                        // );
                      },

                      child: Text(
                        "Esqueci minha senha",
                        style: context.cusotomFontes.textBoldItalic.copyWith(
                          color: ColorsConstants.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: tamanho.maxWidth * 0.5,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        await login();
                      },
                      child: Text(
                        'Entrar',
                        style: context.cusotomFontes.textBold.copyWith(
                          color: ColorsConstants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: tamanho.maxWidth * 0.3,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popAndPushNamed(Rotas.registrarEmpresa);
                      },

                      child: Text(
                        "Cadastrar-se",
                        style: context.cusotomFontes.textBoldItalic.copyWith(
                          color: ColorsConstants.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> login() async {
    final token = await controller.login(
      emailController.text,
      senhaController.text,
    );
    if (token!.isNotEmpty) {
      Provider.of<AuthProvider>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).login(emailController.text, token['token']);
    }
  }

  Future<void> validarPlano() async {
    String isPlano = await Provider.of<AuthProvider>(
      // ignore: use_build_context_synchronously
      context,
      listen: false,
    ).verificarPlano();
    if (isPlano == '!Teste') {
      showPlanoDialog('Teste');
      return;
    }
    if (isPlano == '!Plano') {
      showPlanoDialog('Outro');
      return;
    }
    if (isPlano == 'Finalizado') {
      showPlanoDialog('Plano');
      return;
    }
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushNamedAndRemoveUntil(Rotas.home, (route) => false);
  }

  Future<void> showPlanoDialog(String value) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            value == "Teste"
                ? "Periodo de Teste Encerrado"
                : value == "Plano"
                ? "Plano Expirado"
                : 'Sem plano ativo',
            style: context.cusotomFontes.textBold.copyWith(
              color: ColorsConstants.appBarColor,
            ),
          ),
          content: Text(
            value == "Teste"
                ? 'Seu período de teste gratuito chegou ao fim.\nPara continuar aproveitando os benefícios realize a assinatura.'
                : value == "Plano"
                ? 'Seu plano expirou.\nPara continuar aproveitando os benefícios realize a assinatura.'
                : 'Você não possui um plano ativo.\nPara continuar aproveitando os benefícios realize a assinatura.',
            style: context.cusotomFontes.textRegular.copyWith(
              color: ColorsConstants.appBarColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final token = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                ).token;

                Navigator.of(context).pushNamedAndRemoveUntil(
                  Rotas.premium,
                  (route) => false,
                  arguments: {"token": token},
                );
              },
              child: Text(
                'OK',
                style: context.cusotomFontes.textBoldItalic.copyWith(
                  color: ColorsConstants.appBarColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
