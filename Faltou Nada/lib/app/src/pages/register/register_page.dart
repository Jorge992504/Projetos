import 'dart:developer';
import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/models/register_user_model.dart';
import 'package:faltou_nada/app/src/pages/register/register_controller.dart';
import 'package:faltou_nada/app/src/pages/register/register_state.dart';
import 'package:faltou_nada/app/src/widgets/custom_buttom.dart';
import 'package:faltou_nada/app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  bool obscureText = true;
  bool valido = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nomeController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode nomeFocus;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nomeController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    nomeFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    nomeController.dispose();
    nomeFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterController, RegisterState>(
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
            showSuccess(state.errorMessage ?? "Sucesso");
            await Provider.of<AuthProvider>(
              context,
              listen: false,
            ).autualizarUsearioSP();
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
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, c) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        ImageConstants.loginMascote,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 250,
                        width: context.percentWidth(0.9),
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsConstants.fundoCard,
                        ),
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      height: valido ? 40 : 60,
                                      labelText: 'E-mail',
                                      controller: emailController,
                                      focusNode: emailFocus,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          nomeFocus.requestFocus();
                                        } else {
                                          emailFocus.requestFocus();
                                        }
                                      },
                                      validator: Validatorless.multiple([
                                        Validatorless.required(
                                          'E-mail obrigatorio',
                                        ),
                                        Validatorless.email('E-mail invalido'),
                                      ]),
                                    ),

                                    CustomTextFormField(
                                      height: valido ? 40 : 60,
                                      labelText: 'Nome',
                                      controller: nomeController,
                                      focusNode: nomeFocus,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          passwordFocus.requestFocus();
                                        } else {
                                          emailFocus.requestFocus();
                                        }
                                      },
                                      validator: Validatorless.multiple([
                                        Validatorless.required(
                                          'Nome obrigatorio',
                                        ),
                                      ]),
                                    ),
                                    CustomTextFormField(
                                      height: valido ? 40 : 60,
                                      labelText: 'Senha',
                                      obscureText: obscureText,
                                      focusNode: passwordFocus,
                                      controller: passwordController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          passwordFocus.unfocus();
                                        } else {
                                          passwordFocus.requestFocus();
                                        }
                                      },
                                      validator: Validatorless.multiple([
                                        Validatorless.required(
                                          'Senha obrigatoria',
                                        ),
                                        Validatorless.min(
                                          4,
                                          'Senha tem que conter mais de 4 digitos',
                                        ),
                                      ]),
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
                                    CustomButtom(
                                      label: 'Salvar',
                                      onPressed: () async {
                                        final valid =
                                            formKey.currentState?.validate() ??
                                            false;
                                        if (valid) {
                                          RegisterUserModel model =
                                              RegisterUserModel(
                                                email: emailController.text,
                                                name: nomeController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                          final result = await controller
                                              .register(model);
                                          if (result['token'] != null) {
                                            final atualziar =
                                                await Provider.of<AuthProvider>(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  listen: false,
                                                ).atualizar(
                                                  result['token'],
                                                  emailController.text,
                                                );
                                            if (atualziar) {
                                              setState(() {
                                                valido = !valido;
                                              });
                                            } else {
                                              log('Nao atualizou o token');
                                            }
                                          }
                                        } else {
                                          log('Token vazio');
                                          setState(() {
                                            valido = !valido;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
