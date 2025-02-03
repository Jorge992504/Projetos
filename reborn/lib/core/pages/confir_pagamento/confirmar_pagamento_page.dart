import 'dart:async';

import 'package:flutter/material.dart';

import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/widgets/reborn_app_bar.dart';

class ConfirmarPagamentoPage extends StatefulWidget {
  const ConfirmarPagamentoPage({super.key});

  @override
  State<ConfirmarPagamentoPage> createState() => _ConfirmarPagamentoPageState();
}

class _ConfirmarPagamentoPageState extends State<ConfirmarPagamentoPage> {
  double _progress = 0.0;
  late Timer _time;

  @override
  void initState() {
    super.initState();
    _time = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _time.cancel(); // Para o timer quando o progresso atinge 100%
          Navigator.of(context).popAndPushNamed(Rotas.home);
        }
      });
    });
  }

  @override
  void dispose() {
    _time.cancel(); // Cancela o timer ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RebornAppBar(),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, top: 10),
            alignment: Alignment.topCenter,
            width: context.screenMetadeLargura(0.8),
            height: 250,
            child: Image.asset("assets/imagens/qr.png"),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 300, left: 20),
            width: context.screenMetadeLargura(0.9),
            height: 100,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black, width: 0.3),
            // ),
            child: Text(
              "Nestos momentos só temos como forma de pagamento pix, mas estamos trabalhando para mejorar o serviço oferecido.",
              style: context.textEstilo.textExtraBold.copyWith(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 300, left: 10),
            child: SizedBox(
              height: 50,
              width: context.screenMetadeLargura(0.9),
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.white,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  // Text("${(_progress * 100).round()}%"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
