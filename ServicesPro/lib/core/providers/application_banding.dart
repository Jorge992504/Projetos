import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
import 'package:servicespro/src/controllers/register_controller.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/repository/login_repository.dart';
import 'package:servicespro/src/repository/register_repository.dart';
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
            ChangeNotifierProvider(
              create: (context) => WebSocketProvider(
                authProvider: AuthProvider(
                  loginRepository: context.read<LoginRepository>(),
                  sharedPreferences: snapshot.data!,
                ),
              ),
            ),

            BlocProvider(
              create: (context) => RegisterController(
                RegisterRepository(restClient: context.read<RestClient>()),
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
