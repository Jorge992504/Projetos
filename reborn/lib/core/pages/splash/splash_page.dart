import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:reborn/core/providers/auth_provider.dart';
//import 'package:reborn/core/repositorio/login_repositorio.dart';
import 'package:reborn/core/rotas/rotas.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
//===============saber-se-o-usuario-esta-logado-ou-nao==========================
  Future<void> loading() async {
    final isLoading = Provider.of<AuthProvider>(context, listen: false).loading;
    if (!isLoading) {
      final isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
      if (isAuth) {
        Navigator.of(context).popAndPushNamed(Rotas.home);
      } else {
        textUsuario.clear();
        textSenha.clear();
        Navigator.of(context).popAndPushNamed(Rotas.login);
      }
    }
  }

  @override
  void initState() {
    super.initState();
//==============================================================================
    WidgetsBinding.instance.addPostFrameCallback((_) => loading());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            // alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: context.screenLargura,
              height: context.screenAltura,
              child: Image.asset(
                'assets/imagens/fundo2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
