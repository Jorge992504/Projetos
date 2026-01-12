import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/custom_images.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        loadingPage();
      }
    });
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

  Future<void> loadingPage() async {
    bool isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
    if (isAuth) {
      bool validarToken = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).validarToken();
      if (!mounted) return;
      if (validarToken) {
        UsuarioModel usuarioModel = Provider.of<AuthProvider>(
          context,
          listen: false,
        ).usuarioModel;
        if (usuarioModel.tipoUsuario == "Cliente") {
          await Provider.of<AuthProvider>(
            context,
            listen: false,
          ).salvarDadosUsuario();
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(Rotas.clientHome);
          }
        } else if (usuarioModel.tipoUsuario == "Prestador") {
          await Provider.of<AuthProvider>(
            context,
            listen: false,
          ).salvarDadosUsuario();
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(Rotas.employeeHome);
          }
        } else {
          Navigator.of(context).pushReplacementNamed(Rotas.login);
        }
      }
    } else {
      Navigator.of(context).pushReplacementNamed(Rotas.login);
    }
  }
}
