import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/implementacoes_interfaz/auth_login_impl.dart';
import 'package:reborn/core/providers/auth_provider.dart';
//import 'package:reborn/core/modelos/modelo_login.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

//import '../custom_dio/custom_dio.dart';
//import 'package:reborn/core/providers/auth_provider.dart';

//import '../custom_dio/custom_dio.dart';

class ProviderClasse extends StatelessWidget {
  final Widget child;

  const ProviderClasse({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: ((context) => CustomDio()),
        ),
        Provider<LoginRepository>(
          create: (context) => AuthLoginImpl(dio: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read()),
          lazy: false,
        )
      ],
      child: child,
    );
  }
}
