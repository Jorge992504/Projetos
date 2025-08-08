import 'package:faltou_nada/app/src/pages/home/home_controller.dart';
import 'package:faltou_nada/app/src/pages/home/home_page.dart';
import 'package:faltou_nada/app/src/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();
  static Widget page() => MultiProvider(
        providers: [
          Provider<HomeRepository>(
            create: (context) => HomeRepository(
              restClient: context.read(),
            ),
          ),
          Provider<HomeController>(
            create: (context) => HomeController(
              context.read<HomeRepository>(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
