import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:servicespro/core/env/env.dart';
import 'package:servicespro/core/http/my_http.dart';
import 'package:servicespro/services_pro_app.dart';

void main() async {
  await initializeDateFormatting('pt_BR');
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const ServicesProApp());
}
