import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/bot%C3%B5es/button_cadastro.dart';
import 'package:reborn/core/bot%C3%B5es/button_entrar.dart';
import 'package:reborn/core/componentes/login_componentes/texfield_senha.dart';
import 'package:reborn/core/componentes/login_componentes/textfield_usuario.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/pages/login/login_controller.dart';
import 'package:reborn/core/pages/login/login_state.g.dart';
import 'package:reborn/core/pages/login/login_status.dart';
import 'package:reborn/core/providers/auth_provider.dart';
import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/base_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

final textUsuario = TextEditingController();
final textSenha = TextEditingController();

class _LoginPage extends BaseState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
//---------------messages-para-saber-se-o-login-deu certo-----------------------
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          loginError: () {
            hideLoader();
            showError('Usuário ou senha inavalidos');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar login');
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed(Rotas.home);
          },
        );
      },
//------------------------------------------------------------------------------
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   // backgroundColor: Colors.transparent,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         //implementar a tela de ajuda
        //       },
        //       icon: const Icon(Icons.help_outline_rounded),
        //       color: Colors.grey,
        //     ),
        //   ],
        // ),
        // extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: context.screenMetadeLargura(0.3),
                height: 100,
                child: ClipOval(
                  child: Image.asset(
                    'assets/imagens/activovo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            TextFieldUsuario(
              textUsuario: textUsuario,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldSenha(
              textSenha: textSenha,
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              // margin: const EdgeInsets.only(top: 250),
              child: BotonEntrar(
                label: 'Entrar',
                onPressed: () {
                  controller.login(textUsuario.text, textSenha.text);
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 20),
              child: BotonCadastrar(
                label: 'Ainda não tem cadastro?',
                label1: 'Cadastre-se',
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(Rotas.cadastro);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
