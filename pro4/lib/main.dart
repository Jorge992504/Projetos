import 'dart:io';

import 'package:cep_app/my_http.dart';
import 'package:cep_app/pages/home_page.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
