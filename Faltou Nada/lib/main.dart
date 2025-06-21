import 'package:faltou_nada/app/core/env/env.dart';
import 'package:faltou_nada/app/faltou_nada_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await Env.env.load();
  runApp(const FaltouNadaApp());
}
