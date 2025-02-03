import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';

import 'package:reborn/core/pages/home/home_controller.dart';
import 'package:reborn/core/pages/home/home_state.dart';
import 'package:reborn/core/pages/home/widgets/dia_semana.dart';
import 'package:reborn/core/pages/home/widgets/exercicios_tela.dart';
import 'package:reborn/core/pages/home/widgets/sem_treino.dart';

import 'package:reborn/core/providers/auth_provider.dart';
import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends BaseState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        controller.listarTreino();
      },
    );
  }

  String obterDiaSemana() {
    DateTime data = DateTime.now();
    List<String> diaSemana = [
      'Domingo',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado'
    ];
    return diaSemana[data.weekday];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: SizedBox(
          width: 130,
          height: 70,
          child: Image.asset(
            'assets/imagens/nome.png',
            fit: BoxFit.cover,
          ),
        ),
        leading: Builder(
          builder: ((context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            );
          }),
        ),
      ),
      drawer: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(provider.model.nome),
                    accountEmail: Text(provider.model.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.windows
                              ? Colors.blue[100]
                              : Colors.white,
                      backgroundImage: NetworkImage(provider.model.foto),
                      child: null,
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        trailing: const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        title: const Text(
                          'Perfil',
                          style: TextStyle(color: Colors.black),
                        ),
                        textColor: Colors.grey,
                        onTap: () {},
                      ),
                      ListTile(
                        trailing: const Icon(
                          Icons.star_outlined,
                          color: Colors.green,
                        ),
                        title: const Text(
                          'Plano premium',
                          style: TextStyle(color: Colors.black),
                        ),
                        textColor: Colors.grey,
                        onTap: () {
                          Navigator.of(context)
                              .popAndPushNamed(Rotas.planopremium);
                        },
                      ),
                      ListTile(
                        trailing: const Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                        title: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.black),
                        ),
                        textColor: Colors.grey,
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .sair();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Rotas.login, (route) => false);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Rotas.login, (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          String nomeDiaSemana = obterDiaSemana();
          return Stack(
            children: [
              DiaSemana(
                nome: nomeDiaSemana,
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 50),
                width: context.screenLargura,
                height: context.screenAltura,
                child: state.exe.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.exe.length,
                        itemBuilder: (contex, index) {
                          final exe = state.exe[index];
                          return InkWell(
                            onTap: () async {
                              // final controller = context.read<HomeController>();
                              await Navigator.of(context)
                                  .pushNamed(Rotas.detailexercicio, arguments: {
                                'exercicio': exe,
                              });
                            },
                            child: ExerciciosTela(
                              exe: exe,
                            ),
                          );
                        },
                      )
                    : const Align(
                        alignment: Alignment.center, child: SemTreino()),
              ),
            ],
          );
        },
      ),
    );
  }
}
