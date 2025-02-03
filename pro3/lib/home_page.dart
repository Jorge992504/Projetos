import 'package:flutter/material.dart';
import 'package:introducao_flutter/singlenton_build_context.dart';

String text = "Texto de teste";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Home Page"),
            Text('$context.id'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/Stateful'); //chamada das outras telas
              },
              child: Text("Ir para Stateful"), //nome do botão
            ),
          ],
        ),
      ),
    );
  }
}
