import 'package:dente/src/pages/reset_password/reset_password_controller.dart';
import 'package:dente/src/pages/reset_password/reset_password_page.dart';
import 'package:dente/src/repository/reset_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordRouter {
  ResetPasswordRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ResetPasswordRepository>(
        create: (context) =>
            ResetPasswordRepository(restClient: context.read()),
      ),
      Provider<ResetPasswordController>(
        create: (context) =>
            ResetPasswordController(context.read<ResetPasswordRepository>()),
      ),
    ],
    child: const ResetPasswordPage(),
  );
}
