import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:servicespro/core/router/rotas.dart';

class LocalNotificacaoService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static late GlobalKey<NavigatorState> navigatorKey;

  static Future<void> init() async {
    // 🔹 ANDROID
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 🔹 IOS
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) async {
        log("🔥 CLIQUEI NA NOTIFICAÇÃO 🔥");
        final payload = details.payload;
        if (payload != null) {
          final data = jsonDecode(payload);

          final int usuarioId = data['usuarioId'] is int
              ? data['usuarioId']
              : int.tryParse(data['usuarioId'].toString()) ?? 0;

          final String usuarioNome = data['usuarioNome']?.toString() ?? '';
          log("data: $usuarioId - $usuarioNome");
          await Navigator.pushNamed(
            navigatorKey.currentState!.context,
            Rotas.chat,
            arguments: {'usuarioId': usuarioId, 'usuarioNome': usuarioNome},
          );
        } else {
          log("null-Payload: $payload");
        }
      },
    );

    // 🔥 ANDROID 13+ → pedir permissão em runtime
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }

    // 🔥 iOS → mostrar notificação mesmo em foreground (opcional)
    if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  static Future<void> show({
    required String title,
    required String body,
    required String payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'chat_channel',
      'Mensagens',
      importance: Importance.max,
      priority: Priority.high,
    );

    /// IOS
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificacaoDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificacaoDetails,
      payload: payload,
    );
  }
}
