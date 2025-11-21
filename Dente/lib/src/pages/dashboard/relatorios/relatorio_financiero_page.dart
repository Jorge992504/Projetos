import 'package:flutter/material.dart';

class RelatorioFinancieroPage extends StatefulWidget {
  const RelatorioFinancieroPage({super.key});

  @override
  State<RelatorioFinancieroPage> createState() =>
      RelatorioFinancieroPageState();
}

class RelatorioFinancieroPageState extends State<RelatorioFinancieroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatorios Financieros')),
      body: Container(),
    );
  }
}
