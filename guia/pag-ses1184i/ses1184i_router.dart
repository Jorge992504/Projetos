import 'package:flutter/material.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_controller.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_page.dart';
import 'package:hsmobile/app/repositories/ses1184i/ses1184i_repository.dart';
import 'package:provider/provider.dart';

class Ses1184iRouter {
  Ses1184iRouter._();
  static Widget page() => MultiProvider(
        providers: [
          Provider<Ses1184iRepository>(
            create: (context) => Ses1184iRepository(dio: context.read()),
          ),
          Provider<Ses1184iController>(
            create: (context) =>
                Ses1184iController(context.read<Ses1184iRepository>()),
          ),
        ],
        child: Ses1184iPage(),
      );
}
