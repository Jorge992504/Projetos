import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return MultiProvider(
          providers: [
            Provider<SharedPreferences>(create: (context) => snapshot.data!),
            Provider(create: (context) => RestClient()),
            Provider<AuthRepository>(
              create: (context) => AuthRepository(
                restClient: RestClient(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => AuthProvider(
                prefs: snapshot.data!,
                loginRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
