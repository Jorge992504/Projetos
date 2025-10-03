import 'dart:async';

import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_page.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RegistrarEmpresaPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          maxRadius: 100,
          minRadius: 100,
          backgroundColor: Colors.transparent,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 600),
            child: Image.asset(
              ImageConstants.logo,
              width: context.percentWidth(0.15),
              height: context.percentHeight(0.15),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
