import 'package:activovo/src/pages/payment/card_payment/widgets/deyail_card_payment.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

class CardPaymentPage extends StatelessWidget {
  const CardPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: const SingleChildScrollView(child: DeyailCardPayment()),
    );
  }
}
