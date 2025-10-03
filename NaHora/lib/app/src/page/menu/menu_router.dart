import 'package:flutter/widgets.dart';
import 'package:nahora/app/core/rest_client/rest_client.dart';
import 'package:nahora/app/src/page/menu/menu_controllers.dart';
import 'package:nahora/app/src/page/menu/menu_page.dart';
import 'package:nahora/app/src/repositorio/menu_repository.dart';
import 'package:provider/provider.dart';

class MenuRouter {
  MenuRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<MenuControllers>(
        create: (context) => MenuControllers(context.read<MenuRepository>()),
      ),
      Provider<MenuRepository>(
        create: (context) =>
            MenuRepository(restClient: context.read<RestClient>()),
      ),
    ],
    child: const MenuPage(),
  );
}
