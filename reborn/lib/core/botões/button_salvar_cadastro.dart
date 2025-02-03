import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class ButtonSalvarCadastro extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const ButtonSalvarCadastro({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 200),
      child: SizedBox(
        width: context.screenMetadeLargura(0.8),
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: context.textEstilo.textSemiBold.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
