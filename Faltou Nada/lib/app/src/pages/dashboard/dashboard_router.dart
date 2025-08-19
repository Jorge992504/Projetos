import 'package:faltou_nada/app/src/pages/dashboard/dashboard_controller.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_page.dart';
import 'package:faltou_nada/app/src/repository/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardRouter {
  DashboardRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<DashboardRepository>(
        create: (context) => DashboardRepository(restClient: context.read()),
      ),
      Provider<DashboardController>(
        create: (context) =>
            DashboardController(context.read<DashboardRepository>()),
      ),
    ],
    child: const DashboardPage(),
  );
}
