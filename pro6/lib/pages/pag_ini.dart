import 'package:activovo/buttons/cadastrar.dart';
import 'package:activovo/buttons/entrar_button.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:activovo/size_tela/size_extensions.dart';
import 'package:flutter/material.dart';

class PagIni extends StatefulWidget {
  const PagIni({super.key});

  @override
  State<PagIni> createState() => _PgaIniState();
}

class _PgaIniState extends State<PagIni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo'),
      ),
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter, // para q a imagem fique no fundo
              child: SizedBox(
                //a caixa aonde vai ir a imagem
                width:
                    context.screenWidth, //faz a imagem ser do tamanho da tela
                height: context.screenHeight,
                child: Image.asset(
                  'assets/images/fundo.png',
                  fit: BoxFit.cover,
                ), //insire a imagem
              ),
            ),
            Center(
              child: SizedBox(
                width: context.screenWidth - 300,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: context.screenHeight,
                    width: context.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EntrarButton(
                    width: context.percentWidth(.2),
                    height: 35,
                    label: 'Entrar',
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(RotasPages.home);
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
            )
          ],
        ),
      ),
    );
  }
}
