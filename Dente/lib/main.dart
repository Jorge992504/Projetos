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

  runApp(const DenteApp());
}
