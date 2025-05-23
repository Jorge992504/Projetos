import 'dart:developer';

import 'package:activovo/src/pages/login/login_page.dart';
import 'package:activovo/src/pages/splash/splash_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPages extends ConsumerStatefulWidget {
  const SplashPages({super.key});

  @override
  ConsumerState<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends ConsumerState<SplashPages> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;
  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 100 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
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
              .pushNamedAndRemoveUntil(Rotas.login, (routas) => false);
        },
        data: (data) {
          switch (data) {
            case SplashState.logge:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.home, (routas) => false);
            case SplashState.loggeVip:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.homeVip, (routas) => false);
            case _:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.login, (routas) => false);
          }
        },
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 70),
            height: _logoAnimationHeight,
            child: AnimatedOpacity(
              onEnd: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    settings: const RouteSettings(
                      name: Rotas.login,
                    ),
                    pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                    ) {
                      return const LoginPage();
                    },
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                  (router) => false,
                );
              },
              duration: const Duration(seconds: 3),
              opacity: _animationOpacityLogo,
              curve: Curves.easeIn,
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageConstante.activoco,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 80),
            child: Text(
              'Bem-vindo Vovô',
              style: context.fontes.textExtraBold.copyWith(
                fontSize: 26,
                color: ColorsConstants.greyTitulos,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 140),
            child: Text(
              'carregando suas informações',
              style: context.fontes.textLight.copyWith(
                fontSize: 14,
                color: ColorsConstants.greyTitulos,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: 60,
          //     height: 60,
          //     margin: const EdgeInsets.only(bottom: 150),
          //     child: const Image(
          //       alignment: Alignment.bottomCenter,
          //       width: 2,
          //       image: AssetImage(
          //         ImageConstante.loading,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
