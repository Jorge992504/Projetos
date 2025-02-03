import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/implementacoes_interfaz/home_repository_impl.dart';

import 'package:reborn/core/pages/home/home_controller.dart';
import 'package:reborn/core/pages/home/home_page.dart';

import 'package:reborn/core/repositorio/home_repository.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<HomeRepository>(
            create: (context) => HomeRepositoryImpl(
              dio: context.read<CustomDio>(),
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
