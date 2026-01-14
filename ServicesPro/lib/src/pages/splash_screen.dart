import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
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
  Timer? _retryTimer;
  String _message = "Preparando o ambiente para você...";
  RestClient restClient = RestClient();

  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
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
          Text(_message, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Future<void> _startFlow() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;

    final hasInternet = await _hasInternet();
    if (hasInternet) {
      final apiOk = await _checkApi();
      if (apiOk) {
        await loadingPage();
      } else {
        _onNoInternet();
      }
    } else {
      _onNoInternet();
    }
  }

  Future<bool> _hasInternet() async {
    final connectivity = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return connectivity != ConnectivityResult.none;
  }

  void _onNoInternet() {
    if (!mounted) return;
    setState(() {
      _message = "Sem internet ou problemas de conexão.\nTentando reconectar.";
    });
    _retryTimer?.cancel();
    _retryTimer = Timer(Duration(seconds: 2), _startFlow);
  }

  Future<bool> _checkApi() async {
    try {
      final response = await restClient.unauth.get(
        "/controller/auth/valid/cone",
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
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
