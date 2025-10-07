import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_controller.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:dente/src/repository/login_repository.dart';
import 'package:dente/src/repository/registrar_empresa_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                prefs: snapshot.data!,
                loginRepository: context.read<LoginRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => RegistrarEmpresaController(
                RegistrarEmpresaRepository(
                  restClient: context.read<RestClient>(),
                ),
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
