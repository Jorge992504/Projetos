import 'dart:developer';

import 'package:barber/src/core/ui/constant/color_constants.dart';
import 'package:barber/src/core/ui/helpers/messages.dart';
import 'package:barber/src/features/auth/login/login_page.dart';
import 'package:barber/src/features/splash/splash_vm.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
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
            case SplashState.loggeAdm:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.adm, (routas) => false);
            case SplashState.loggeEmployee:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.employee, (routas) => false);
            case _:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Rotas.login, (routas) => false);
          }
        },
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstante.backgroundImage,
            ),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  settings: const RouteSettings(name: Rotas.login),
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
              child: Image.asset(
                ImageConstante.imageLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
