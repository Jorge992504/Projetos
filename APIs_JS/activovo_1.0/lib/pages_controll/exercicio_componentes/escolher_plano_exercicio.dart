//import 'package:activovo/rotas/rotas_pages.dart';

import 'package:activovo/size_tela/size_extensions.dart';
//import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EscolherPlano extends StatefulWidget {
  // final Exercicio exercicio;
  const EscolherPlano({super.key});

  @override
  State<StatefulWidget> createState() => _EscolherPlano();
}

class _EscolherPlano extends State<EscolherPlano> {
  //late bool _select = false;
  bool escDia = false;
  Color colorCard1 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard2 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard3 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard4 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard5 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard6 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard7 = const Color.fromARGB(255, 127, 211, 130);
  Color colorCard8 = const Color.fromARGB(255, 127, 211, 130);
  Color colorRed = Colors.red;
  String exe1 = 'Exercicio 1º';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/fundo.png',
              fit: BoxFit.cover,
              width: context.screenWidth,
              height: context.screenHeight,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                color: colorCard1,
                elevation: 6,
                child: SizedBox(
                  width: context.screenWidth,
                  height: 40,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(exe1),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(left: 200),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  colorCard1 = Colors.grey;
                                  escDia = true;
                                });
                              },
                              icon: const Icon(
                                Icons.check_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              colorCard1 =
                                  const Color.fromARGB(255, 127, 211, 130);
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: colorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//-------------------------------------2-----------------------------------------------------------------------------------------------
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Card(
                color: colorCard2,
                elevation: 6,
                child: SizedBox(
                  width: context.screenWidth,
                  height: 40,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text('Exericio 2º'),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(left: 200),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  colorCard2 = Colors.grey;
                                });
                              },
                              icon: const Icon(
                                Icons.check_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              colorCard2 =
                                  const Color.fromARGB(255, 127, 211, 130);
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: colorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//---------------------------------------3---------------------------------------------------------------------------------------------
            Container(
              margin: const EdgeInsets.only(top: 110),
              child: Card(
                color: colorCard3,
                elevation: 6,
                child: SizedBox(
                  width: context.screenWidth,
                  height: 40,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text('Exericio 3º'),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(left: 200),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  colorCard3 = Colors.grey;
                                });
                              },
                              icon: const Icon(
                                Icons.check_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              colorCard3 =
                                  const Color.fromARGB(255, 127, 211, 130);
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: colorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//---------------------------------------4---------------------------------------------------------------------------------------------
            Container(
              margin: const EdgeInsets.only(top: 160),
              child: Card(
                color: colorCard4,
                elevation: 6,
                child: SizedBox(
                  width: context.screenWidth,
                  height: 40,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text('Exericio 3º'),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(left: 200),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  colorCard4 = Colors.grey;
                                });
                              },
                              icon: const Icon(
                                Icons.check_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              colorCard4 =
                                  const Color.fromARGB(255, 127, 211, 130);
                            });
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: colorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
