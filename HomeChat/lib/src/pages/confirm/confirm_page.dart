import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/confirm/confirm_vm.dart';
import 'package:homechat/src/pages/confirm/widgets/widgets_confirms.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class ConfirmPage extends ConsumerStatefulWidget {
  const ConfirmPage({super.key});

  @override
  ConsumerState<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends ConsumerState<ConfirmPage> {
  final cod1EC = TextEditingController();
  final cod2EC = TextEditingController();
  final cod3EC = TextEditingController();
  final cod4EC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    cod1EC.dispose();
    cod2EC.dispose();
    cod3EC.dispose();
    cod4EC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final confirmCod = ref.watch(confirmVmProvider.notifier);
    ref.listen(confirmVmProvider, (_, state) {
      switch (state) {
        case ConfirmStateStatus.initial:
          break;
        case ConfirmStateStatus.success:
          Messages.showSuccess('Confirmação realizada com sucesso', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (router) => false);
        case ConfirmStateStatus.error:
          Messages.showError("Erro ao confirmar conta", context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação da conta'),
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      TextFormField1(cod1EC: cod1EC),
                      const SizedBox(width: 14),
                      TextFormField2(cod2EC: cod2EC),
                      const SizedBox(width: 14),
                      TextFormField3(cod3EC: cod3EC),
                      const SizedBox(width: 14),
                      TextFormField4(cod4EC: cod4EC),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButtonConfirm(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError('Informe o código', context);
                        case true:
                          final codigoS =
                              "${cod1EC.text}${cod2EC.text}${cod3EC.text}${cod4EC.text}";
                          final codigoI = int.parse(codigoS);
                          confirmCod.confirma(codigoI);
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextButtonConfirm(
                    onPressed: () {
                      Messages.showInfo('Aguarde o código', context);
                    },
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
