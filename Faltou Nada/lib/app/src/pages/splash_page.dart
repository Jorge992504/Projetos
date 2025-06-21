import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
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
      final isAuth = Provider.of(context, listen: false).isAuthenticated;
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
      loading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: Image.asset(
              ImageConstants.logo32,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
