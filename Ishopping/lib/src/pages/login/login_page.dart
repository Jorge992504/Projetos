import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ishopping/core/router/rotas.dart';
import 'package:ishopping/src/pages/login/login_state.dart';
import 'package:ishopping/src/pages/login/login_vm.dart';

import 'package:ishopping/src/ui/colors/colors_constants.dart';

import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';
import 'package:ishopping/src/ui/helpers/messages.dart';
import 'package:ishopping/src/ui/image/image_constants.dart';
import 'package:ishopping/src/ui/widgets/ishopping_elevation_button.dart';
import 'package:ishopping/src/pages/login/widgets/login_text_form_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  //
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //
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
                children: [
                  Container(
                    height: 80,
                    width: context.screenHeight,
                    margin: const EdgeInsets.only(top: 150),
                    child: const Image(
                      image: AssetImage(ImageConstants.logo),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  LoginTextFormFieldEmail(
                    emailEC: emailEC,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  LoginTextFormFieldPassword(
                    passwordEC: passwordEC,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 165.0),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: Text(
                  //       'Esqueceu a senha?',
                  //       style: context.fontes.textMedium.copyWith(
                  //         fontSize: 14,
                  //         color: ColorsConstants.label,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: IshoppingElevationButton(
                      label: 'ACESSAR',
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case (false || null):
                            Messages.showError('Campos inválidos', context);
                          case true:
                            login(emailEC.text, passwordEC.text);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Rotas.register);
                      },
                      child: Text(
                        'Criar conta',
                        style: context.fontes.textMedium.copyWith(
                          fontSize: 14,
                          color: ColorsConstants.label,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
