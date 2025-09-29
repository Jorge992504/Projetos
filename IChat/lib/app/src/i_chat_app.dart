import 'package:flutter/material.dart';
import 'package:ichat/app/core/providers/application_banding.dart';
import 'package:ichat/app/core/router/rotas.dart';
import 'package:ichat/app/src/pages/chat/chat_router.dart';
import 'package:ichat/app/src/pages/home/home_router.dart';
import 'package:ichat/app/src/pages/login/login_router.dart';
import 'package:ichat/app/src/pages/splash/splash_page.dart';
import 'package:ichat/app/src/socket/web_socket_controller.dart';

class IChatApp extends StatelessWidget {
  const IChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: WebSocketController(
        child: MaterialApp(
          title: 'iChat',
          theme: ThemeData(primarySwatch: Colors.blue),
          routes: {
            Rotas.splash: (context) => const SplashPage(),
            Rotas.home: (context) => HomeRouter.page(),
            Rotas.login: (context) => LoginRouter.page(),
            Rotas.chat: (context) => ChatRouter.page(),
          },
        ),
      ),
    );
  }
}
