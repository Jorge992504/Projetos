import 'package:activovo/src/pages/payment/payment_modify_user_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPixPayment extends ConsumerStatefulWidget {
  const DetailPixPayment({super.key});

  @override
  ConsumerState<DetailPixPayment> createState() => _DetailPixPaymentState();
}

class _DetailPixPaymentState extends ConsumerState<DetailPixPayment> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        final result = ref.watch(paymentModifyUserVmProvider.notifier);
        result.modifyUser();
        Messages.showSuccess('Pagamento feito com succeso', context);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Rotas.splashValidPayment, (router) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.only(left: 60),
          width: 150,
          height: 85,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Escane o código QR ou copie a chave pix.',
              style: context.fontes.textExtraBold.copyWith(
                fontSize: 16,
                color: ColorsConstants.greyTitulos,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          width: 150,
          height: 150,
          child: Image.asset(
            ImageConstante.qrC,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          width: context.WidthScreenM(0.8),
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'fefwfwfwfewfwefwefewefwfewfewfewfewfewfewewfewfewfwefew',
              style: context.fontes.textLight.copyWith(
                fontSize: 14,
                color: ColorsConstants.greyBotoes,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'copiar',
                style: context.fontes.textLight.copyWith(
                  color: ColorsConstants.greyTitulos,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
