import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_images.dart';
import 'package:nahora/app/src/page/home/home_page.dart';

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
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 600),
            child: Image.asset(
              ImageConstants.burger,
              width: 1000,
              height: 1000,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
