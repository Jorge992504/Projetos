import 'package:flutter/material.dart';
import 'package:introducao_flutter/home_page.dart';
import 'package:introducao_flutter/home_page_statefull.dart';
import 'package:introducao_flutter/singleton_patterm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var s1 = SingletonPatterm.instance;
    s1.id = 10;
    var s2 = SingletonPatterm.instance;
    print(s2.id);
    var s3 = SingletonPatterm.instance;
    var s4 = SingletonPatterm.instance;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(), //navegação entre telas
        '/Stateful': (context) => HomePageStateFul(),
      },
    );
  }
}
