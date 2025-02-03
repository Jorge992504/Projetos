import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ishopping/core/router/rotas.dart';
import 'package:ishopping/src/pages/splash/splash_vm.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';
import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';
import 'package:ishopping/src/ui/helpers/messages.dart';
import 'package:ishopping/src/ui/image/image_constants.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
//

  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar login', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.login, (touter) => false);
        },
        data: (data) {
          switch (data) {
            case SplashStateStatus.login:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.home, (routes) => false);
            case _:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.login, (routes) => false);
          }
        },
      );
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              height: 80,
              width: context.screenWidth,
              alignment: Alignment.topCenter,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              // ),
              child: const Image(
                image: AssetImage(ImageConstants.logo),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 300),
              height: 80,
              width: context.screenWidth,
              alignment: Alignment.bottomCenter,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              // ),
              child: Text(
                'IShopping',
                style: context.fontes.textExtraBold.copyWith(
                  fontSize: 20,
                  color: ColorsConstants.label,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 80,
              width: context.screenWidth,
              alignment: Alignment.bottomCenter,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              // ),
              child: const Image(
                image: AssetImage(ImageConstants.loading),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
