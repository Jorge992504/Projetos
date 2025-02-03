import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/login/login_state.dart';
import 'package:homechat/src/pages/login/login_vm.dart';
import 'package:homechat/src/pages/login/widgets/elevated_button_login.dart';
import 'package:homechat/src/pages/login/widgets/text_button_criar_conta.dart';
import 'package:homechat/src/pages/login/widgets/text_button_password_login.dart';
import 'package:homechat/src/pages/login/widgets/text_form_field_login.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
        case LoginState(status: LoginStateStatus.login):
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (router) => false);
          break;
      }
    });
    return Scaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormFieldEmail(
                      emailEC: emailEC,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormFieldPassword(
                      passwordEC: passwordEC,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 35),
                    child: TextButtonPasswordLogin(
                      label: 'Esqueceu sua senha?',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  ElevatedButtonLogin(
                    label: 'ENTRAR',
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError('Campos inválidos', context);
                        case true:
                          login(emailEC.text, passwordEC.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Spacer(),
                  TextButtonCriarConta(
                    label: 'CRIAR CONTA',
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Rotas.register, (router) => false);
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
