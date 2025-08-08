import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/pages/login/login_controller.dart';
import 'package:faltou_nada/app/src/pages/login/login_state.dart';
import 'package:faltou_nada/app/src/widgets/custom_buttom.dart';
import 'package:faltou_nada/app/src/widgets/custom_text_form_field.dart';
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
  bool obscureText = true;
  bool valido = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginController, LoginState>(
        listener: (context, state) {
      state.status.matchAny(
        any: hideLoader,
        loading: showLoader,
        loaded: hideLoader,
        failure: () {
          showError(state.errorMessage ?? 'Login ou senha inválidos');
          hideLoader();
        },
        sucess: () async {
          hideLoader(); // <- Primeiro esconde o loading
          showSuccess('Sucesso ao realizar login');
          await Provider.of<AuthProvider>(context, listen: false)
              .autualizarUsearioSP();
          Navigator.of(context).pushNamedAndRemoveUntil(
            Rotas.home,
            (route) => false,
          );
        },
      );
    }, builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: LayoutBuilder(builder: (context, c) {
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
                    height: 230,
                    width: context.percentWidth(0.9),
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 30),
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
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      passwordFocus.requestFocus();
                                    } else {
                                      emailFocus.requestFocus();
                                    }
                                  },
                                  validator: Validatorless.multiple(
                                    [
                                      Validatorless.required(
                                          'E-mail obrigatorio'),
                                      Validatorless.email('E-mail invalido'),
                                    ],
                                  ),
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
                                  validator: Validatorless.multiple(
                                    [
                                      Validatorless.required(
                                          'Senha obrigatoria'),
                                      Validatorless.min(4,
                                          'Senha tem que conter mais de 4 digitos'),
                                    ],
                                  ),
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
                                  label: 'Entrar',
                                  onPressed: () {
                                    final valid =
                                        formKey.currentState?.validate() ??
                                            false;
                                    if (valid) {
                                      controller.login(emailController.text,
                                          passwordController.text, context);
                                      setState(() {
                                        valido = !valido;
                                      });
                                    } else {
                                      setState(() {
                                        valido = !valido;
                                      });
                                    }
                                  },
                                ),
                                Container(
                                  height: 20,
                                  width: context.percentWidth(0.9),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Esqueceu sua senha?',
                                          style: context
                                              .fontesLetras.textRegular
                                              .copyWith(
                                            fontSize: 12,
                                            color: ColorsConstants.black,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          size: 18,
                                          color: ColorsConstants.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 100,
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Criar conta',
                                      style: context.fontesLetras.textLight
                                          .copyWith(
                                        fontSize: 12,
                                        color: ColorsConstants.black,
                                      ),
                                    ),
                                  ),
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
          }),
        ),
      );
    });
  }
}
