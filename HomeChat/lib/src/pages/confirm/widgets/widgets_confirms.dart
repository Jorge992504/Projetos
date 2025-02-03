import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homechat/src/ui/sizes/size_screen.dart';
import 'package:validatorless/validatorless.dart';

class TextFormField1 extends StatelessWidget {
  final TextEditingController cod1EC;
  const TextFormField1({super.key, required this.cod1EC});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.blue,
        border: const Border(
          bottom: BorderSide(color: Colors.blue, width: 1),
          right: BorderSide(color: Colors.blue, width: 1),
          left: BorderSide(color: Colors.blue, width: 1),
          top: BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      child: TextFormField(
        controller: cod1EC,
        validator: Validatorless.required('Informa o código'),
      ),
    );
  }
}

//!1/////////////////////////////////////////////////////////////////////////////
class TextFormField2 extends StatelessWidget {
  final TextEditingController cod2EC;
  const TextFormField2({super.key, required this.cod2EC});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.blue,
        border: const Border(
          bottom: BorderSide(color: Colors.blue, width: 1),
          right: BorderSide(color: Colors.blue, width: 1),
          left: BorderSide(color: Colors.blue, width: 1),
          top: BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      child: TextFormField(
        controller: cod2EC,
        validator: Validatorless.required('Informa o código'),
      ),
    );
  }
}

//!1/////////////////////////////////////////////////////////////////////////////
class TextFormField3 extends StatelessWidget {
  final TextEditingController cod3EC;
  const TextFormField3({super.key, required this.cod3EC});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.blue,
        border: const Border(
          bottom: BorderSide(color: Colors.blue, width: 1),
          right: BorderSide(color: Colors.blue, width: 1),
          left: BorderSide(color: Colors.blue, width: 1),
          top: BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      child: TextFormField(
        controller: cod3EC,
        validator: Validatorless.required('Informa o código'),
      ),
    );
  }
}

//!1/////////////////////////////////////////////////////////////////////////////
class TextFormField4 extends StatelessWidget {
  final TextEditingController cod4EC;
  const TextFormField4({super.key, required this.cod4EC});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.blue,
        border: const Border(
          bottom: BorderSide(color: Colors.blue, width: 1),
          right: BorderSide(color: Colors.blue, width: 1),
          left: BorderSide(color: Colors.blue, width: 1),
          top: BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      child: TextFormField(
        controller: cod4EC,
        validator: Validatorless.required('Informa o código'),
      ),
    );
  }
}

//!1/////////////////////////////////////////////////////////////////////////////
class ElevatedButtonConfirm extends StatelessWidget {
  final VoidCallback onPressed;
  const ElevatedButtonConfirm({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: context.screenMetWidth(0.4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Confirmar'),
      ),
    );
  }
}
// //!1/////////////////////////////////////////////////////////////////////////////

class TextButtonConfirm extends StatefulWidget {
  final VoidCallback onPressed;
  const TextButtonConfirm({super.key, required this.onPressed});

  @override
  State<TextButtonConfirm> createState() => _TextButtonConfirmState();
}

class _TextButtonConfirmState extends State<TextButtonConfirm> {
  bool isDisabled = true; // Começa desabilitado
  int secondsRemaining = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      isDisabled = true;
      secondsRemaining = 90;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        setState(() {
          isDisabled = false;
        });
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextButton(
        onPressed: isDisabled
            ? null
            : () {
                widget.onPressed();
                _startTimer(); // Reinicia o temporizador após clique
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Reenviar código'),
            if (isDisabled) ...[
              const SizedBox(width: 8),
              Text(
                '($secondsRemaining)',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void startCountdown() {
    _startTimer(); // Função para iniciar o temporizador manualmente
  }
}

class ConfirmAndResendScreen extends StatefulWidget {
  const ConfirmAndResendScreen({super.key});

  @override
  State<ConfirmAndResendScreen> createState() => _ConfirmAndResendScreenState();
}

class _ConfirmAndResendScreenState extends State<ConfirmAndResendScreen> {
  final GlobalKey<_TextButtonConfirmState> _textButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Inicia a contagem regressiva automaticamente ao abrir a página
    _textButtonKey.currentState?.startCountdown();
  }

  void _onConfirmPressed() {
    // Inicia o temporizador ao clicar em "Confirmar"
    _textButtonKey.currentState?.startCountdown();
  }

  void _onResendPressed() {
    // Lógica para reenviar o código
    print('Código reenviado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar e Reenviar Código')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButtonConfirm(onPressed: _onConfirmPressed),
            const SizedBox(height: 16),
            TextButtonConfirm(
              key: _textButtonKey,
              onPressed: _onResendPressed,
            ),
          ],
        ),
      ),
    );
  }
}
