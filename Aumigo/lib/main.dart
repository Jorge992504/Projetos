import 'dart:io';

import 'package:aumigo/core/env/env.dart';
import 'package:aumigo/core/http/my_http.dart';
import 'package:aumigo/src/aumigo_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const AumigoApp());
}
