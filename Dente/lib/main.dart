import 'dart:io';

import 'package:dente/core/env/env.dart';
import 'package:dente/core/http/my_http.dart';
import 'package:dente/dente_app.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // WindowOptions windowOptions = WindowOptions(center: true);
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.maximize();
  //   await windowManager.show();
  //   await windowManager.focus();
  // });
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const DenteApp());
}
