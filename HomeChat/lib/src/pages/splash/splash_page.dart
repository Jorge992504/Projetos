import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/splash/splash_vm.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Rotas.login, (router) => false);
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
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Chat',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
    );
  }
}
