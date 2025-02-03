import 'package:flutter/material.dart';

class HomePageStateFul extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageStateFul();
  }
}

class _HomePageStateFul extends State<HomePageStateFul> {
  String text = "Home Page Stateful";

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
            Text(text), // nome do label
            //ElevatedButton(
            //  onPressed: () {
            //    setState(() {
            //      text = "Texto alterado";
            //    });
            //  },
            //  child: Text("Alterar texto"), //nome do botão
            //),
            ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/');
                Navigator.pop(context);
              },
              child: Text("Ir para Home Page"), //nome do botão
            ),
          ],
        ),
      ),
    );
  }
}
