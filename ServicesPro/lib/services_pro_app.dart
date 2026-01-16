import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:servicespro/core/providers/application_banding.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/theme/config_theme.dart';
import 'package:servicespro/src/pages/chat_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_categorias_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_perfil_screen.dart';
import 'package:servicespro/src/pages/employee_pages/employee_detalhes_pedido_screen.dart';
import 'package:servicespro/src/pages/employee_pages/employee_principal_screen.dart';
import 'package:servicespro/src/pages/finalizar_servico_screen.dart';
import 'package:servicespro/src/pages/client_pages/client_historico_servico_screen.dart';
import 'package:servicespro/src/pages/receber_codigo_redefinir_senha_screen.dart';
import 'package:servicespro/src/pages/redefinir_senha_screen.dart';
import 'package:servicespro/src/pages/register_client_employee_screen.dart';
import 'package:servicespro/src/pages/splash_screen.dart';
import 'package:servicespro/src/pages/suporte_screen.dart';
import 'package:servicespro/src/pages/termos_politica_screen.dart';
import 'package:servicespro/src/routers/client/client_home_router.dart';
import 'package:servicespro/src/routers/login_router.dart';
import 'package:servicespro/src/routers/register_router.dart';

class ServicesProApp extends StatelessWidget {
  const ServicesProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: MaterialApp(
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
          Rotas.clientPerfil: (context) => ClientPerfilScreen(),
          Rotas.clientHistoricoServico: (context) =>
              ClientHistoricoServicoScreen(),
          Rotas.clientFinalizarServico: (context) => FinalizarServicoScreen(),
          Rotas.suporte: (context) => SuporteScreen(),
          Rotas.clientCategoriasServicos: (context) => ClientCategoriasScreen(),
          Rotas.clientHome: (context) => ClientHomeRouter.page(),
          Rotas.employeeHome: (context) => EmployeePrincipalScreen(),
          Rotas.employeeDetalhesServico: (context) =>
              EmployeeDetalhesPedidoScreen(),
          Rotas.chat: (context) => ChatScreen(),
          Rotas.login: (context) => LoginRouter.page(),
          Rotas.register: (context) => RegisterRouter.page(),
          Rotas.termosPolitica: (context) => TermosPoliticaScreen(),
          Rotas.registerClientEmployee: (context) =>
              RegisterClientEmployeeScreen(),
          Rotas.receberCodigo: (context) => ReceberCodigoRedefinirSenhaScreen(),
          Rotas.redefinirSenha: (context) => RedefinirSenhaScreen(),
        },
      ),
    );
  }
}
