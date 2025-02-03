import 'dart:io';

import 'package:calculadora/calculadora_app.dart';
import 'package:calculadora/my_http.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttp();
  runApp(const CalculadoraApp());
}
