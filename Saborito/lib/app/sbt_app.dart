import 'package:flutter/material.dart';
import 'package:saborito/app/core/provider/provider_binding.dart';
import 'package:saborito/app/core/ui/theme/theme_config.dart';
import 'package:saborito/app/page/home/home_router.dart';
import 'package:saborito/app/page/produto_detail/produto_detail_router.dart';
import 'package:saborito/app/page/splash/splash_page.dart';
import 'package:saborito/app/rotas/rotas.dart';

class SbtApp extends StatelessWidget {
  const SbtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderBinding(
      child: MaterialApp(
        title: "Sobotiros",
        theme: ThemeConfig.theme,
        routes: {
          Rotas.splash: (context) => const SplashPage(),
          Rotas.home: (context) => HomeRouter.page,
          Rotas.produtoDetail: (context) => ProdutoDetailRouter.page,
        },
      ),
    );
  }
}
