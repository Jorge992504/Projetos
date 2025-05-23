import 'package:delivery/app/core/ui/theme/theme_config.dart';
import 'package:delivery/app/pages/home/home_router.dart';
import 'package:delivery/app/pages/product_detail/product_detail_router.dart';

import 'package:delivery/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Dw9DeliveryApp extends StatelessWidget {
  const Dw9DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const SplahsPage(),
        '/home': (context) => HomeRouter.page,
        '/productDetail': (context) => ProductDetailRouter.page,
      },
    );
  }
}
