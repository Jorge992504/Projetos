import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ishopping/core/router/rotas.dart';
import 'package:ishopping/src/pages/register/register_vm.dart';
import 'package:ishopping/src/pages/register/widgets/register_text_form_field.dart';

import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/helpers/messages.dart';

import 'package:ishopping/src/ui/image/image_constants.dart';
import 'package:ishopping/src/ui/widgets/ishopping_elevation_button.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  //
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final passwordConfirmEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(registerVmProvider.notifier);
    ref.listen(registerVmProvider, (_, state) {
      switch (state) {
        case RegisterStateStatus.initial:
          break;
        case RegisterStateStatus.success:
          Messages.showSuccess('Cadastro realizado com sucesso', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (router) => false);
        case RegisterStateStatus.error:
          Messages.showError("Erro ao registrar usuário", context);
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  height: 34,
                ),
                RegisterTextFormFieldName(
                  nameEC: nameEC,
                ),
                const SizedBox(
                  height: 24,
                ),
                RegisterTextFormFieldEmail(
                  emailEC: emailEC,
                ),
                const SizedBox(
                  height: 24,
                ),
                RegisterTextFormFieldPassword(
                  passwordEC: passwordEC,
                ),
                const SizedBox(
                  height: 24,
                ),
                RegisterTextFormFieldPasswordConfirm(
                  passwordConfirmEC: passwordConfirmEC,
                  passwordEC: passwordEC,
                ),
                const SizedBox(
                  height: 54,
                ),
                // Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: IshoppingElevationButton(
                    label: 'CADASTRAR',
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError(
                              'Os campos não podem estar vazíos', context);
                        case true:
                          result.register(
                              name: nameEC.text,
                              email: emailEC.text,
                              password: passwordEC.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
