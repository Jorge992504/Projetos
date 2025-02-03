import 'package:activovo/src/pages/payment/card_payment/widgets/text_car_payment.dart';
import 'package:activovo/src/pages/payment/payment_modify_user_state.dart';
import 'package:activovo/src/pages/payment/payment_modify_user_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeyailCardPayment extends ConsumerStatefulWidget {
  const DeyailCardPayment({super.key});

  @override
  ConsumerState<DeyailCardPayment> createState() => _DeyailCardPaymentState();
}

class _DeyailCardPaymentState extends ConsumerState<DeyailCardPayment> {
  final cep = TextEditingController();
  final cpf = TextEditingController();
  final nome = TextEditingController();
  final end = TextEditingController();
  final card = TextEditingController();
  final cv = TextEditingController();
  final vdd = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(paymentModifyUserVmProvider.notifier);
    ref.listen(paymentModifyUserVmProvider, (_, state) {
      switch (state) {
        case PaymentModifyUserState.initial:
          break;

        // ignore: constant_pattern_never_matches_value_type
        case PaymentModifyUserStateStatus.success:
          Messages.showSuccess('Pagamento feito com succeso', context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Rotas.splashValidPayment, (router) => false);

        // ignore: constant_pattern_never_matches_value_type
        case PaymentModifyUserStateStatus.error:
          Messages.showError("Erro ao registrar usuário", context);
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            'Insira os dados do cartão.',
            style: context.fontes.textExtraBold.copyWith(
              fontSize: 16,
              color: ColorsConstants.greyTitulos,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: context.WidthScreenM(0.35),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsConstants.greyEntryF,
                      ),
                      child: TextCarPayment(
                        controller: cep,
                        label: 'CEP',
                        requiValid: 'CEP obrigatorio',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: context.WidthScreenM(0.58),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsConstants.greyEntryF,
                      ),
                      child: TextCarPayment(
                        controller: cpf,
                        label: 'CPF',
                        requiValid: 'CPF obrigatorio',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: context.WidthScreenM(1),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsConstants.greyEntryF,
                  ),
                  child: TextCarPayment(
                    controller: nome,
                    label: 'Nome do titular do cartão',
                    requiValid: 'Nome obrigatorio',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: context.WidthScreenM(1),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsConstants.greyEntryF,
                  ),
                  child: TextCarPayment(
                    controller: end,
                    label: 'Endereço para cobrança',
                    requiValid: 'Endereço obrigatorio',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: context.WidthScreenM(1),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsConstants.greyEntryF,
                  ),
                  child: TextCarPayment(
                    controller: card,
                    label: 'N° do cartão',
                    requiValid: 'N° do cartão obrigatorio',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: context.WidthScreenM(0.35),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsConstants.greyEntryF,
                      ),
                      child: TextCarPayment(
                        controller: cv,
                        label: 'CVV',
                        requiValid: 'CVV obrigatorio',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: context.WidthScreenM(0.35),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsConstants.greyEntryF,
                      ),
                      child: TextCarPayment(
                        controller: vdd,
                        label: 'Validade',
                        requiValid: 'Validade obrigatoria',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: context.WidthScreenM(0.9),
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (false || null):
                          Messages.showError('Campos inválidos', context);
                        case true:
                          result.modifyUser();
                          Messages.showSuccess(
                              'Pagamento feito com succeso', context);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Rotas.splashValidPayment, (router) => false);
                      }
                    },
                    child: Text(
                      'Pagar',
                      style: context.fontes.textBold.copyWith(
                        fontSize: 16,
                        color: ColorsConstants.greyBotoes,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
