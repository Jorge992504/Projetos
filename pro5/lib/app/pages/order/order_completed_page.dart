import 'package:delivery/app/core/ui/helpers/size_extensions.dart';

import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(.2),
              ),
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido.',
                style: context.textStyles.textExtraBold.copyWith(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              DeliveryButton(
                label: 'Fechar',
                onPressed: () {
                  Navigator.pop(context);
                },
                width: context.percentWidth(.9),
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
