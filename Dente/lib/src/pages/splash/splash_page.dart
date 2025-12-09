import 'dart:async';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
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
      bool validToken = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).validarToken();
      if (validToken) {
        String isPlano = await Provider.of<AuthProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).verificarPlano();
        if (isPlano == '!Teste') {
          showPlanoDialog('Teste');
          return;
        }
        if (isPlano == '!Plano') {
          showPlanoDialog('Outro');
          return;
        }
        if (isPlano == 'Finalizado') {
          showPlanoDialog('Plano');
          return;
        }
        await Provider.of<AuthProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).atualizarUsuario();
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(Rotas.home);
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(Rotas.login);
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(Rotas.login);
    }
    // Provider.of<AuthProvider>(context, listen: false).logout();
    // Navigator.of(context).popAndPushNamed(Rotas.login);
  }

  Future<void> showPlanoDialog(String value) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            value == "Teste"
                ? "Periodo de Teste Encerrado"
                : value == "Plano"
                ? "Plano Expirado"
                : 'Sem plano ativo',
            style: context.cusotomFontes.textBold.copyWith(
              color: ColorsConstants.appBarColor,
            ),
          ),
          content: Text(
            value == "Teste"
                ? 'Seu período de teste gratuito chegou ao fim.\nPara continuar aproveitando os benefícios realize a assinatura.'
                : value == "Plano"
                ? 'Seu plano expirou.\nPara continuar aproveitando os benefícios realize a assinatura.'
                : 'Você não possui um plano ativo.\nPara continuar aproveitando os benefícios realize a assinatura.',
            style: context.cusotomFontes.textRegular.copyWith(
              color: ColorsConstants.appBarColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final token = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                ).token;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Rotas.premium,
                  (route) => false,
                  arguments: {"token": token},
                );
              },
              child: Text(
                'OK',
                style: context.cusotomFontes.textBoldItalic.copyWith(
                  color: ColorsConstants.appBarColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
