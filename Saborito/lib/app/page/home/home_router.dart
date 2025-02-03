import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saborito/app/core/rest_client/custom_dio.dart';
import 'package:saborito/app/page/home/home_controller.dart';
import 'package:saborito/app/page/home/home_page.dart';
import 'package:saborito/app/repositories/produtos/produtos_repository.dart';
import 'package:saborito/app/repositories/produtos/produtos_repository_impl.dart';

class HomeRouter {
  HomeRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<ProdutosRepository>(
            create: (context) => ProdutosRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
