import 'package:flutter/material.dart';

class NavigatorPages extends StatefulWidget {
  final int cont;
  const NavigatorPages({super.key, required this.cont});

  @override
  State<NavigatorPages> createState() => _NavigatorPages();
}

class _NavigatorPages extends State<NavigatorPages> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          index;
        });
      },
      selectedIndex: widget.cont,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Treino',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.mode_edit_outline_sharp,
          ),
          label: 'Criar treino',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.edit_document,
          ),
          label: 'Editar treino',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.delete_sweep_outlined,
          ),
          label: 'Deletar treino',
        ),
      ],
    );
  }
}
