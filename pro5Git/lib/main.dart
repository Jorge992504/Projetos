import 'dart:io';

import 'package:delivery/app/core/env/env.dart';
import 'package:delivery/my_http.dart';
import 'package:flutter/material.dart';
import 'package:delivery/app/dw9_delivery_app.dart';

Future<void> main() async {
  await Env.i.load();
  HttpOverrides.global = MyHttp();
  runApp(const Dw9DeliveryApp());
}
