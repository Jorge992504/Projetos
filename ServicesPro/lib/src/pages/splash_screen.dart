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
        // Navigator.pushReplacementNamed(context, Rotas.employeeHome);
        // Navigator.pushReplacementNamed(context, Rotas.clientHome);
        // Navigator.pushReplacementNamed(context, Rotas.login);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Selecione o tipo de usuário"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Rotas.clientHome);
                    },
                    child: Text("Cliente"),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Rotas.employeeHome,
                      );
                    },
                    child: Text("Funcionário"),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Rotas.login);
                    },
                    child: Text("Realizar login"),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Rotas.register);
                    },
                    child: Text("Realizar cadastro"),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }
}
