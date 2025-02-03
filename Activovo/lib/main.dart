import 'dart:io';

import 'package:activovo/my_http.dart';
import 'package:activovo/src/activovo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  HttpOverrides.global = MyHttp();
  runApp(const ProviderScope(child: ActivovoApp()));
}
