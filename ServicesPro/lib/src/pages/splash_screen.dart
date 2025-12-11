import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/custom_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              minRadius: 40,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  LogoConstants.logo,
                  alignment: Alignment.center,
                  cacheHeight: 150,
                  cacheWidth: 150,
                ),
              ),
            ),
          ),
          LoadingAnimationWidget.newtonCradle(
            color: ColorsConstants.azulColor,
            size: 60,
          ),
          Text("Preparando o ambiente para você..."),
        ],
      ),
    );
  }

  Future<void> loading() async {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Rotas.home);
      }
    });
  }
}
