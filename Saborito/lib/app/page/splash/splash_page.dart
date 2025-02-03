import 'package:flutter/material.dart';
import 'package:saborito/app/core/ui/helpers/size_extensions.dart';
import 'package:saborito/app/core/ui/widgets/sbt_button.dart';
import 'package:saborito/app/rotas/rotas.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xff140e0e),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: context.percentHight(.25),
                width: context.screenWidth,
                child: Image.asset(
                  'assets/imagens/hamburguer.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentHight(.30),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/imagens/Saboritos.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SbtButton(
                    width: context.percentWidth(.6),
                    label: 'Accesar',
                    onPresses: () {
                      Navigator.of(context).popAndPushNamed(Rotas.home);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
