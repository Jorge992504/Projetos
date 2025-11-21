import 'package:dente/src/pages/payment/payment_controller.dart';
import 'package:dente/src/pages/payment/payment_page.dart';
import 'package:dente/src/repository/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentRouter {
  PaymentRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<PaymentRepository>(
        create: (context) => PaymentRepository(restClient: context.read()),
      ),
      Provider<PaymentController>(
        create: (context) =>
            PaymentController(context.read<PaymentRepository>()),
      ),
    ],
    child: const PaymentPage(),
  );
}
