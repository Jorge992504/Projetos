import 'dart:io';

import 'package:faltou_nada/app/core/env/env.dart';
import 'package:faltou_nada/app/core/http/my_http.dart';
import 'package:faltou_nada/app/faltou_nada_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const FaltouNadaApp());
}
