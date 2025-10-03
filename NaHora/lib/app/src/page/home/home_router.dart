import 'package:flutter/widgets.dart';
import 'package:nahora/app/core/rest_client/rest_client.dart';
import 'package:nahora/app/src/page/home/home_controller.dart';
import 'package:nahora/app/src/page/home/home_page.dart';
import 'package:nahora/app/src/repositorio/home_repository.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<HomeController>(
        create: (context) => HomeController(context.read<HomeRepository>()),
      ),
      Provider<HomeRepository>(
        create: (context) =>
            HomeRepository(restClient: context.read<RestClient>()),
      ),
    ],
    child: const HomePage(),
  );
}
