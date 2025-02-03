import 'package:flutter/material.dart';
import 'package:reborn/core/pages/doenca/auxiliar_pages/doenca_page.dart';

import 'package:reborn/core/pages/dias_treino/auxilia_pages/treino_page.dart';
import 'package:reborn/core/pages/treino/treino_page.dart';
import 'package:reborn/core/widgets/reborn_app_bar.dart';

class DoencaPage extends StatefulWidget {
  const DoencaPage({
    super.key,
  });

  @override
  State<DoencaPage> createState() => _DoencaPage();
}

class _DoencaPage extends State<DoencaPage> {
  int cont = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.arrow_back,
      //     ),
      //   ),
      // ),
      appBar: RebornAppBar(),
//------------------------menu-navegacao----------------------------------------
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(
            () {
              cont = index;
            },
          );
        },
        selectedIndex: cont,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.sick),
            icon: Icon(
              color: Colors.brown,
              Icons.sick_outlined,
            ),
            label: 'Doenças',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_today_rounded),
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.brown,
            ),
            label: 'Dias de Treinamento',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.save),
            icon: Icon(
              color: Colors.brown,
              Icons.save_as,
            ),
            label: 'Criar treino',
          ),
        ],
      ),

      body: <Widget>[
        const DoencasPage(),
        const DiasTreinoPage(),
        const TreinoPage(),
      ][cont],
    );
  }
}
