import 'package:activovo/buttons/cadastrar.dart';
import 'package:activovo/buttons/entrar_button.dart';
import 'package:activovo/core/providers/auth_provider.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:activovo/size_tela/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PagIni extends StatefulWidget {
  const PagIni({super.key});

  @override
  State<PagIni> createState() => _PgaIniState();
}

class _PgaIniState extends State<PagIni> {
  final GlobalKey<_PgaIniState> myWidgetKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool _loading = true;

  //controlar login
  final userLog = TextEditingController();
  final senhaLog = TextEditingController();
  @override
  void dispose() {
    userLog.dispose();
    senhaLog.dispose();
    super.dispose();
  }

  @override
  void initState() {
    () async {
      await Future.delayed(const Duration(seconds: 1));
      bool login = Provider.of<AuthProvider>(context, listen: false).isAuth;
      if (login) {
        await Navigator.of(context).popAndPushNamed(RotasPages.exercicio);
      } else {
        setState(() {
          _loading = false;
        });
      }
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: ColoredBox(
                color: const Color(0XFF140E0E),
                child: Stack(
                  children: [
                    //imagem fundo
                    Align(
                      alignment: Alignment
                          .bottomCenter, // para q a imagem fique no fundo
                      child: SizedBox(
                        //a caixa aonde vai ir a imagem
                        width: context
                            .screenWidth, //faz a imagem ser do tamanho da tela
                        height: context.screenHeight,
                        child: Image.asset(
                          'assets/images/fundo.png',
                          fit: BoxFit.cover,
                        ), //insire a imagem
                      ),
                    ),
                    //imagem logo
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10), // Define o espaço desejado no topo
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 330,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //entry field
                        Form(
                          key: formKey,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(120.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20.0,
                                    //width: 300.0, agranda o TextField
                                  ),
                                  TextField(
                                    controller: userLog,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10.0),
                                      labelText: 'Usuário',
                                      prefixIcon: FaIcon(FontAwesomeIcons.user),
                                      prefixIconConstraints: BoxConstraints(
                                        minHeight: 24,
                                        minWidth: 34,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  TextField(
                                    controller: senhaLog,
                                    obscureText: true, //senha
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10.0),
                                      labelText: 'Senha',
                                      prefixIcon: FaIcon(FontAwesomeIcons.key),
                                      prefixIconConstraints: BoxConstraints(
                                        minHeight: 24,
                                        minWidth: 34,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //botão entrar
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              EntrarButton(
                                width: context.percentWidth(.2),
                                height: 35,
                                label: 'Entrar',
                                onPressed: () async {
                                  if (await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .usuaLogin(userLog.text, senhaLog.text)) {
                                    if (context.mounted) {
                                      Navigator.of(context).popAndPushNamed(
                                          RotasPages.exercicio);
                                    }
                                  }
                                },
                              ),
                              const Text(''),
                              Cadastrar(
                                width: context.percentWidth(.4),
                                height: 35,
                                label: 'Cadastrar',
                                onPressed: () {
                                  Navigator.of(context)
                                      .popAndPushNamed(RotasPages.cadastro);
                                },
                              ),
                              const Text(''),
                              const Text(''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
