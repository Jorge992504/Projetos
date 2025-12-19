import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/theme/config_theme.dart';
import 'package:servicespro/src/pages/client_pages/client_categorias_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_perfil_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_prestadores_categoria_screen.dart';
import 'package:servicespro/src/pages/finalizar_servico_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_historico_servico_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_principal_screem.dart';
import 'package:servicespro/src/pages/splash_screen.dart';
import 'package:servicespro/src/pages/suporte_screen.dart';

class ServicesProApp extends StatelessWidget {
  const ServicesProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ConfigTheme.lighTheme,
      darkTheme: ConfigTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        Rotas.splash: (context) => SplashScreen(),
        Rotas.home: (context) => ClientPrincipalScreem(),
        Rotas.clientHistoricoServico: (context) =>
            ClientHistoricoServicoScreen(),
        Rotas.clientFinalizarServico: (context) => FinalizarServicoScreen(),
        Rotas.clientPerfil: (context) => ClientPerfilScreen(),
        Rotas.suporte: (context) => SuporteScreen(),
        Rotas.clientCategoriasServicos: (context) => ClientCategoriasScreen(),
        Rotas.clientPrestadoresCategorias: (context) =>
            ClientPrestadoresCategoriaScreen(),
      },
    );
  }
}
