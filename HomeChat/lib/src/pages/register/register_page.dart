import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/register/register_vm.dart';
import 'package:homechat/src/pages/register/widgets/elevated_button_save.dart';
import 'package:homechat/src/pages/register/widgets/text_form_field_register.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmapasswordEC = TextEditingController();
  final nameEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final registerVm = ref.watch(registerVmProvider.notifier);
    ref.listen(registerVmProvider, (_, state) {
      switch (state) {
        case RegisterStateStatus.initial:
          break;
        case RegisterStateStatus.success:
          Messages.showSuccess('Cadastro realizado com sucesso', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.confirm, (router) => false);
        case RegisterStateStatus.error:
          Messages.showError("Erro ao registrar usuário", context);
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
                    child: TextFormFieldRegisterName(nameEC: nameEC),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormFieldRegisterEmail(emailEC: emailEC),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        TextFormFieldRegisterPassword(passwordEC: passwordEC),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormFieldRegisterConfirmaPassword(
                        confirmapasswordEC: confirmapasswordEC,
                        passwordEC: passwordEC),
                  ),
                  const Spacer(),
                  ElevatedButtonSave(
                    label: 'FINALIZAR',
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError(
                              'Os campos não podem estar vazíos', context);
                        case true:
                          registerVm.register(
                            name: nameEC.text,
                            email: emailEC.text,
                            password: passwordEC.text,
                          );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 54,
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
