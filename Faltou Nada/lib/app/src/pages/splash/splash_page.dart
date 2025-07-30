import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> loading() async {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: false).isLoading;
    if (!isLoading) {
      final isAuth =
          Provider.of<AuthProvider>(context, listen: false).isAuthenticated;
      if (isAuth) {
        Navigator.of(context).popAndPushNamed(Rotas.home);
      } else {
        Navigator.of(context).popAndPushNamed(Rotas.login);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        loading();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsConstants.buttonBordas, // 👈 cor da borda
              width: 0.5, // 👈 espessura da borda
            ),
            borderRadius: BorderRadius.circular(20.0), // opcional
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                14.0), // se quiser canto arredondado igual à borda
            child: Image.asset(
              ImageConstants.logo32,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
