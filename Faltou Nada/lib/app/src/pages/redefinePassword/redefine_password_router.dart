import 'package:faltou_nada/app/src/pages/redefinePassword/redefine_password_controller.dart';
import 'package:faltou_nada/app/src/pages/redefinePassword/redefine_password_page.dart';
import 'package:faltou_nada/app/src/repository/redefine_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RedefinePasswordRouter {
  RedefinePasswordRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<RedefinePasswordRepository>(
        create: (context) =>
            RedefinePasswordRepository(restClient: context.read()),
      ),
      Provider<RedefinePasswordController>(
        create: (context) => RedefinePasswordController(
          context.read<RedefinePasswordRepository>(),
        ),
      ),
    ],
    child: const RedefinePasswordPage(),
  );
}
