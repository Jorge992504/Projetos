import 'package:delivery/app/core/ui/base_state/base_state.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery/app/pages/auth/login/login_controller.dart';
import 'package:delivery/app/pages/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          loginError: () {
            hideLoader();
            showError('Login ou senha inválidos');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar login');
          },
          success: () {
            hideLoader();
            Navigator.pop(context, true);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: context.textStyles.textTitle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('E-mail obrigatorio'),
                          Validatorless.email('E-mail inválido'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Senha obrigatoria'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: DeliveryButton(
                        onPressed: () {
                          final valid =
                              _formKey.currentState?.validate() ?? false;
                          print(valid);
                          if (valid) {
                            print('entrou no valid');
                            controller.login(email.text, senha.text);
                          } else {
                            print('entrou no nao valid');
                            controller.login(email.text, senha.text);
                          }
                        },
                        label: 'Entrar',
                        width: double.infinity,
                      ),
                    ),
                  ],
                )),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta?',
                        style: context.textStyles.textBold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/auth/register');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textBold.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
