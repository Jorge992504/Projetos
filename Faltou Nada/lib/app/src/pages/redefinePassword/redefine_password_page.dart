import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/pages/redefinePassword/redefine_password_controller.dart';
import 'package:faltou_nada/app/src/pages/redefinePassword/redefine_password_state.dart';
import 'package:faltou_nada/app/src/widgets/custom_buttom.dart';
import 'package:faltou_nada/app/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RedefinePasswordPage extends StatefulWidget {
  const RedefinePasswordPage({super.key});

  @override
  State<RedefinePasswordPage> createState() => _RedefinePasswordPageState();
}

class _RedefinePasswordPageState
    extends BaseState<RedefinePasswordPage, RedefinePasswordController> {
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText2 = true;
  bool valido = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController password2Controller;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode password2Focus;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    password2Focus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    password2Controller.dispose();
    password2Focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RedefinePasswordController, RedefinePasswordState>(
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

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(Rotas.login, (route) => false);
              });
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
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
                                      keyboardType: TextInputType.multiline,
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
                                          'E-mail obrigatorio',
                                        ),
                                        Validatorless.email('E-mail invalido'),
                                      ]),
                                    ),

                                    CustomTextFormField(
                                      height: valido ? 40 : 60,
                                      labelText: 'Nova senha',
                                      controller: passwordController,
                                      focusNode: passwordFocus,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,
                                      obscureText: obscureText,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          password2Focus.requestFocus();
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
                                    CustomTextFormField(
                                      height: valido ? 40 : 60,
                                      labelText: 'Repeta a senha',
                                      controller: password2Controller,
                                      focusNode: password2Focus,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.done,
                                      obscureText: obscureText2,
                                      onFieldSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          password2Focus.unfocus();
                                        } else {
                                          passwordFocus.requestFocus();
                                        }
                                      },
                                      validator: Validatorless.multiple([
                                        Validatorless.required(
                                          'Repeta sua senha',
                                        ),
                                        Validatorless.compare(
                                          passwordController,
                                          'Senhas diferentes',
                                        ),
                                      ]),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscureText2 = !obscureText2;
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
                                      label: 'Redefinir senha',
                                      onPressed: () async {
                                        final valid =
                                            formKey.currentState?.validate() ??
                                            false;
                                        if (valid) {
                                          await controller.redefinirSenha(
                                            emailController.text,
                                            passwordController.text,
                                          );
                                        } else {
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
          );
        },
      ),
    );
  }
}
