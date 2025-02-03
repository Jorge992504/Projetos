import 'package:activovo/src/pages/payment/detail_payment/detail_payment_state.dart';
import 'package:activovo/src/pages/payment/detail_payment/detail_payment_vm.dart';
import 'package:activovo/src/pages/payment/detail_payment/widgets/foco_new_treino.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPaymentPage extends ConsumerWidget {
  const DetailPaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showConfirmarDelete() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorsConstants.greyEntryF,
            title: Text(
              'Qual seria a forma de pagamento?',
              style: context.fontes.textMedium.copyWith(
                fontSize: 14,
                color: ColorsConstants.greyTitulos,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Rotas.detailPaymentPix, (router) => false);
                    },
                    child: Text(
                      'PIX',
                      style: context.fontes.textBold
                          .copyWith(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Rotas.detailPaymentCard, (router) => false);
                    },
                    child: Text(
                      'CARTÃO DE CRÉDITO',
                      style: context.fontes.textBold
                          .copyWith(color: Colors.brown, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    final result = ref.watch(detailPaymentVmProvider.notifier);
    ref.listen(detailPaymentVmProvider, (_, state) {
      switch (state.status) {
        case DetailPaymentStateStatus.initial:
          break;
        case DetailPaymentStateStatus.error:
          Messages.showError(
              'Erro ao registrar as melhoras do novo plano', context);
        case DetailPaymentStateStatus.success:
          Messages.showSuccess('Melhoras cadastradas com succeso', context);
          showConfirmarDelete();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: Column(
        children: [
          FocoNewTreino(
            onPressed: (value) {
              result.addOrRemoveImprovements(value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  final resultD = result.validar();
                  switch (resultD) {
                    case false:
                      Messages.showError(
                          'Selecione as melhoras do novo treino', context);
                    case true:
                      result.registarImprovement();
                      showConfirmarDelete();
                  }
                },
                child: Text(
                  'Continuar',
                  style: context.fontes.textBold.copyWith(
                      color: ColorsConstants.greyBotoes, fontSize: 16),
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: ColorsConstants.greyBotoes,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
