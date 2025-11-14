import 'package:dente/core/providers/application_banding.dart';
import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/theme/config_theme.dart';
import 'package:dente/src/pages/agendamento/agendamento_router.dart';
import 'package:dente/src/pages/atendimento/atendimento_router.dart';
import 'package:dente/src/pages/dashboard/dashboard_router.dart';
import 'package:dente/src/pages/dentista/dentista_router.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_router.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_router.dart';
import 'package:dente/src/pages/historico_paciente/historico_paciente_router.dart';
import 'package:dente/src/pages/home/home_router.dart';
import 'package:dente/src/pages/login/login_router.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_router.dart';
import 'package:dente/src/pages/registrar_paciente/registrar_paciente_router.dart';
import 'package:dente/src/pages/relatorio/relatorio_router.dart';
import 'package:dente/src/pages/reset_password/reset_password_router.dart';
import 'package:dente/src/pages/servicos/servicos_router.dart';
import 'package:dente/src/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DenteApp extends StatelessWidget {
  const DenteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          Rotas.splash: (context) => const SplashPage(),
          Rotas.login: (context) => LoginRouter.page(),
          Rotas.registrarEmpresa: (context) => RegistrarEmpresaRouter.page(),
          Rotas.resetPassword: (context) => ResetPasswordRouter.page(),
          Rotas.home: (context) => HomeRouter.page(),
          Rotas.editarEmpresa: (context) => EditarEmpresaRouter.page(),
          Rotas.agendamento: (context) => AgendamentoRouter.page(),
          Rotas.registrarPaciente: (context) => RegistrarPacienteRouter.page(),
          Rotas.dentista: (context) => DentistaRouter.page(),
          Rotas.servicos: (context) => ServicosRouter.page(),
          Rotas.atendimento: (context) => AtendimentoRouter.page(),
          Rotas.historicoConsultas: (context) =>
              HistoricoConsultasRouter.page(),
          Rotas.historicoPaciente: (context) => HistoricoPacienteRouter.page(),
          Rotas.dashboard: (context) => DashboardRouter.page(),
          Rotas.relatorio: (context) => RelatorioRouter.page(),
        },
      ),
    );
  }
}
