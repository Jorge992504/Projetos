import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichat/app/core/router/rotas.dart';
import 'package:ichat/app/core/ui/base/base_state.dart';
import 'package:ichat/app/src/pages/home/home_controller.dart';
import 'package:ichat/app/src/pages/home/home_state.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:ichat/app/src/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    super.onReady();
    controller.buscaMessagesOfUSer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Provider.of<WebSocketProvider>(context, listen: false).conectado) {
        Provider.of<WebSocketProvider>(context, listen: false).conectar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home ${Provider.of<AuthProvider>(context, listen: false).usuarioModel.email}',
        ),
        leading: IconButton(
          onPressed: () async {
            Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.of(context).pushReplacementNamed(Rotas.login);
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            error: () {
              showError(state.errorMessage ?? 'Login ou senha inválidos');
              hideLoader();
            },
            success: () async {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          final conversas = state
              .conversas; // Supondo que state.conversas seja uma lista de objetos de conversa

          return ListView.builder(
            itemCount: conversas?.length,
            itemBuilder: (context, index) {
              final conversa = conversas![index];
              return ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text(conversa.userFrom ?? ""), // nome do usuário
                subtitle: Text(conversa.message ?? ""), // última mensagem
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    Rotas.chat,
                    arguments: {'userFrom': state.conversas![index].userFrom},
                  );

                  // Atualiza ao voltar
                  controller.buscaMessagesOfUSer();
                  // ignore: use_build_context_synchronously
                  Provider.of<WebSocketProvider>(
                    // ignore: use_build_context_synchronously
                    context,
                    listen: false,
                  ).limparMensagens();
                },
              );
            },
          );
        },
      ),
    );
  }
}
