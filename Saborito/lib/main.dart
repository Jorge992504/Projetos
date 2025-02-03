import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saborito/app/core/config/env/env.dart';
import 'package:saborito/app/sbt_app.dart';
import 'package:saborito/my_http.dart';

Future<void> main() async {
  await Env.i.load();
  HttpOverrides.global = MyHttp();
  runApp(const SbtApp());
}
