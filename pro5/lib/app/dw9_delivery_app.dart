import 'package:delivery/app/core/global/global_context.dart';
import 'package:delivery/app/core/provider/application_binding.dart';
import 'package:delivery/app/core/ui/theme/theme_config.dart';

import 'package:delivery/app/pages/auth/login/login_router.dart';

import 'package:delivery/app/pages/auth/register/register_router.dart';
import 'package:delivery/app/pages/home/home_router.dart';
import 'package:delivery/app/pages/order/order_completed_page.dart';

import 'package:delivery/app/pages/order/order_router.dart';
import 'package:delivery/app/pages/product_detail/product_detail_router.dart';

import 'package:delivery/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Dw9DeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();
  Dw9DeliveryApp({super.key}){
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        routes: {
          '/': (context) => const SplahsPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
