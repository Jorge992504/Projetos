import 'package:flutter/material.dart';
import 'package:ichat/app/core/rest_client/rest_client.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:ichat/app/src/providers/web_socket_provider.dart';
import 'package:ichat/app/src/repository/login_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationBanding extends StatelessWidget {
  final Widget child;
  const ApplicationBanding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return MultiProvider(
          providers: [
            Provider<SharedPreferences>(create: (context) => snapshot.data!),
            Provider(create: (context) => RestClient()),
            Provider<LoginRepository>(
              create: (context) => LoginRepository(restClient: RestClient()),
            ),
            ChangeNotifierProvider(
              create: (context) => AuthProvider(
                sharedPreferences: snapshot.data!,
                loginRepository: context.read<LoginRepository>(),
              ),
            ),
            // Provider WebSocket para escutar mensagens em tempo real
            ChangeNotifierProvider(
              create: (context) => WebSocketProvider(
                usuarioLogado:
                    context.read<AuthProvider>().usuarioModel.email ?? "",
                // usuário logado
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
