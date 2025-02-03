import 'package:activovo/src/pages/payment/pix_payment/widgets/detail_pix_payment.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

class PixPaymentPage extends StatelessWidget {
  const PixPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: const DetailPixPayment(),
    );
  }
}
