import 'package:delivery/app/core/rest_client/custom_dio.dart';
import 'package:delivery/app/pages/home/home_controller.dart';
import 'package:delivery/app/pages/home/home_page.dart';
import 'package:delivery/app/repositories/products/prod_repo.dart';
import 'package:delivery/app/repositories/products/prod_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProdRepo>(
            create: (context) => ProdRepoImpl(
              dio: CustomDio(),
            ),
          ),
          Provider(
            create: (context) => HomeController(context.read()),
          ),
        ],
        child: const HomePage(),
      );
}
