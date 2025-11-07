import 'dart:async';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      _timer.cancel();
      if (mounted) {
        loading();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          maxRadius: 120,
          minRadius: 120,
          backgroundColor: Colors.transparent,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 600),
            child: Image.asset(
              ImageConstants.logo,
              width: context.percentWidth(0.15),
              height: context.percentHeight(0.15),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loading() async {
    bool isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
    if (isAuth) {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).atualizarUsuario();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Rotas.home);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(Rotas.login);
    }
    // Provider.of<AuthProvider>(context, listen: false).logout();
    // Navigator.of(context).popAndPushNamed(Rotas.login);
  }
}
