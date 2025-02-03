// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:reborn/core/componentes/home_componentes/exercicios_card.dart';

class TreinoLista extends StatefulWidget {
  const TreinoLista({
    super.key,
  });

  @override
  State<TreinoLista> createState() => _TreinoLista();
}

class _TreinoLista extends State<TreinoLista> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExerciciosDiaCard(
          nmTreino: "widget.treino.nome",
          nmExercicio: "widget.exe.nome",
          descricao: "widget.exe.descricao",
        ),
      ],
    );
  }
}
