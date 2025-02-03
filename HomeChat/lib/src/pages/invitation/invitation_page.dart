import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/invitation/invitation_vm.dart';
import 'package:homechat/src/pages/invitation/widgets/text_form_fiel.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class InvitationPage extends ConsumerStatefulWidget {
  const InvitationPage({super.key});

  @override
  ConsumerState<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends ConsumerState<InvitationPage> {
  final emailEC = TextEditingController();
  final textEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    textEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final sendEmail = ref.watch(invitationVmProvider.notifier);
    ref.listen(invitationVmProvider, (_, state) {
      switch (state) {
        case InvitationStateStatus.initial:
          break;
        case InvitationStateStatus.success:
          Messages.showSuccess('Cadastro realizado com sucesso', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (router) => false);
        case InvitationStateStatus.error:
          Messages.showError("Erro ao registrar usuário", context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar convite para:'),
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  TextFormFielInvatationEmail(
                    emailEC: emailEC,
                  ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  Expanded(
                    child: TextFormFielText(
                      textEC: textEC,
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case false || null:
                            Messages.showError(
                                'Tem que informar o e-mail', context);
                          case true:
                            sendEmail.invitation(
                              emailEC.text,
                              textEC.text,
                            );
                        }
                      },
                    ),
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
