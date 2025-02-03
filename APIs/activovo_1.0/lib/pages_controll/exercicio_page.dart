import 'package:activovo/core/models/usuario.dart';
import 'package:activovo/core/providers/auth_provider.dart';
import 'package:activovo/pages_controll/exercicio_componentes/exercicio_card.dart';
import 'package:activovo/pages_controll/exercicio_componentes/exercicio_dia.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:activovo/size_tela/size_extensions.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:activovo/size_tela/size_extensions.dart';
//import 'package:activovo/size_tela/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercicioPage extends StatefulWidget {
  final Usuario usuario;
  const ExercicioPage({super.key, required this.usuario});

  @override
  State<ExercicioPage> createState() => _ExercicioPageState();
}

class _ExercicioPageState extends State<ExercicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------------appbar com menu---------------------------------------------------------
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        leading: Builder(
          builder: ((context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.green[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  widget.usuario.nome,
                ),
                accountEmail: Text(
                  widget.usuario.email,
                ),
                currentAccountPicture: CircleAvatar(
                  // ignore: unrelated_type_equality_checks
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.android
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    widget.usuario.nome.substring(0, 1),
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
              ListTile(
                trailing: const Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                ),
                title: const Text('Perfil'),
                textColor: Colors.grey,
                onTap: () {
                  Navigator.of(context).pushNamed(RotasPages.perfil);
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.sticky_note_2_rounded,
                  color: Colors.teal,
                ),
                title: const Text(
                  'Escolher exercicios',
                  style: TextStyle(color: Colors.grey),
                ),
                textColor: Colors.grey,
                onTap: () {
                  Navigator.of(context).pushNamed(RotasPages.plano);
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.grey),
                ),
                textColor: Colors.grey,
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).sair();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RotasPages.inicio, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      //-----------------------------------------------------------------------------------------
//--------itens de exercicios--------------------------------------------------------------------
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/fundo.png',
              fit: BoxFit.cover,
              width: context.screenWidth,
              height: context.screenHeight,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ExercicioCard(
                    label: 'Treino de segunda feira',
                    treino1: ExercicioDia(label: 'Treino 1º: Pernas'),
                    treino2: ExercicioDia(label: 'Treino 2º: Alongamentos'),
                    treino3:
                        ExercicioDia(label: 'Treino 3º: Caminhada estatica'),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ExercicioCard(
                    label: 'Treino de terça feira',
                    treino1: ExercicioDia(label: 'Treino 1º: '),
                    treino2: ExercicioDia(label: 'Treino 2º: '),
                    treino3: ExercicioDia(label: 'Treino 3º: '),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ExercicioCard(
                    label: 'Treino de quarta feira',
                    treino1: ExercicioDia(label: 'Treino 1º: '),
                    treino2: ExercicioDia(label: 'Treino 2º: '),
                    treino3: ExercicioDia(label: 'Treino 3º: '),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ExercicioCard(
                    label: 'Treino de quinta feira',
                    treino1: ExercicioDia(label: 'Treino 1º: '),
                    treino2: ExercicioDia(label: 'Treino 2º: '),
                    treino3: ExercicioDia(label: 'Treino 3º: '),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ExercicioCard(
                    label: 'Treino de sexta feira',
                    treino1: ExercicioDia(label: 'Treino 1º: '),
                    treino2: ExercicioDia(label: 'Treino 2º: '),
                    treino3: ExercicioDia(label: 'Treino 3º: '),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.of(context).popAndPushNamed(RotasPages.inicio);
    //     },
    //   ),
    // );
  }
}
