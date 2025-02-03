import 'package:flutter/material.dart';

class CardCadastro extends StatelessWidget {
  final Widget widget;
  const CardCadastro({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 500,
        width: 500,
        child: Card(
          color: Colors.transparent,
          elevation: 0.5,
          child: widget,
        ),
      ),
    );
  }
}
