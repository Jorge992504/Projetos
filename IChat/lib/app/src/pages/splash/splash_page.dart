import 'package:flutter/material.dart';
import 'package:ichat/app/core/router/rotas.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:ichat/app/src/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        loading();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  Future<void> loading() async {
    bool isAuthenticated = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).isAuthenticated;
    if (isAuthenticated) {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).atualizarUsuarioLogado();
      // ignore: use_build_context_synchronously
      bool isConnected = await conectado();
      if (!isConnected) {
        // ignore: use_build_context_synchronously
        Provider.of<WebSocketProvider>(context, listen: false).conectar();
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(Rotas.home);
    } else {
      bool isConnected = await conectado();
      if (!isConnected) {
        // ignore: use_build_context_synchronously
        Provider.of<WebSocketProvider>(context, listen: false).conectar();
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(Rotas.login);
    }
  }

  Future<bool> conectado() async {
    final wsProvider = Provider.of<WebSocketProvider>(
      context,
      listen: false,
    ).conectado;
    return wsProvider;
  }
}
