//import 'package:delivery/app/core/env/env.dart';
import 'package:delivery/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

//tela de inicio-----------------------------------------------------------------
class SplahsPage extends StatelessWidget {
  const SplahsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Splash'),
      // ),
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment:
                  Alignment.bottomCenter, // para q a imagem fique no fundo
              child: SizedBox(
                // a caixa aonde vai ir a imagem
                width:
                    context.screenWidth, //faz a imagem ser do tamanho da tela
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ), //insire a imagem
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context
                        .percentHeight(.10), //da a posição da imagem na tela
                  ),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(
                    height: 80,
                  ),
                  DeliveryButton(
                    // botão acessar
                    width: context.percentWidth(.6),
                    height: 35,
                    label: 'ACESSAR',
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/home');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      //Column(
      //  children: [
      //    Container(),
      //    DeliveryButton(
      //      width: 120,
      //      height: 30,
      //      label: Env.i['backend_base_url'] ?? '',
      //    ),
      //    //Text(context.screenWidth.toString()), //tamanho da tela
      //    Text(''), // espaço entre o botão e a entryfield
      //    TextFormField(
      //      decoration: InputDecoration(labelText: 'text'),
      //    ),
      //  ],
      //),
    );
  }
}
