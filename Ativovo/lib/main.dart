import 'dart:io';

import 'package:Ativovo/my_http.dart';

import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bem-vindo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
