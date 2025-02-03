import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:homechat/src/pages/chat/chat_page.dart';
import 'package:homechat/src/pages/confirm/confirm_page.dart';
import 'package:homechat/src/pages/home/home_page.dart';
import 'package:homechat/src/pages/invitation/invitation_page.dart';
import 'package:homechat/src/pages/login/login_page.dart';
import 'package:homechat/src/pages/register/register_page.dart';
import 'package:homechat/src/pages/splash/splash_page.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/ui/theme/homechat_theme.dart';
import 'package:homechat/src/ui/widgets/homechat_nav_global_key.dart';

class HomechatApp extends StatelessWidget {
  const HomechatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Home Chat',
          theme: HomechatTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: HomechatNavGlobalKey.instance.navKey,
          routes: {
            Rotas.splash: (context) => const SplashPage(),
            Rotas.home: (context) => const HomePage(),
            Rotas.login: (context) => const LoginPage(),
            Rotas.register: (context) => const RegisterPage(),
            Rotas.chat: (context) => const ChatPage(),
            Rotas.convite: (context) => const InvitationPage(),
            Rotas.confirm: (context) => const ConfirmPage(),
          },
        );
      },
    );
  }
}
