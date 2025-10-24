import 'package:dente/src/pages/historico_consultas/widgets/card_historico_consultas.dart';
import 'package:flutter/material.dart';

class HistoricoConsultasPage extends StatefulWidget {
  const HistoricoConsultasPage({super.key});

  @override
  State<HistoricoConsultasPage> createState() => _HistoricoConsultasPageState();
}

class _HistoricoConsultasPageState extends State<HistoricoConsultasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historico de consultas')),
      body: LayoutBuilder(
        builder: (context, tamanho) {
          return Column(
            children: [
              CardHistoricoConsultas(
                width: 1000,
                height: 80,
                padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              ),
            ],
          );
        },
      ),
    );
  }
}
