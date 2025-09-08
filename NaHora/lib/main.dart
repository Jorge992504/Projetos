import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nahora/app/core/env/env.dart';
import 'package:nahora/app/core/http/my_http.dart';
import 'package:nahora/app/na_hora_app.dart';

Future<void> main() async {
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const NaHoraApp());
}
