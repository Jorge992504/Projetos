// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:delivery/app/core/ui/style/colors_app.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';

class ButtonIncrementarDecrementar extends StatelessWidget {
  final int cont;
  final VoidCallback incrementar;
  final VoidCallback decrementar;

  const ButtonIncrementarDecrementar({
    super.key,
    required this.cont,
    required this.incrementar,
    required this.decrementar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        //sao 3 componentes dentro do botao
        mainAxisAlignment: MainAxisAlignment
            .spaceAround, //faz os componentes ocupar toda a tela
        children: [
          InkWell(
            //faz q quando clickar no menos ou no mas funcione
            onTap: decrementar,
            child: Padding(
              //separar o primeiro componente da borda
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                //primeiro componente
                '-',
                style: context.textStyles.textMedium
                    .copyWith(fontSize: 22, color: Colors.grey),
              ),
            ),
          ),
          Text(
            //segundo componente
            cont.toString(),
            style: context.textStyles.textRegular
                .copyWith(fontSize: 17, color: context.colors.secundary),
          ),
          InkWell(
            onTap: incrementar,
            child: Padding(
              //separar o terceiro componente do segundo
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                //terceiro componente
                '+',
                style: context.textStyles.textMedium
                    .copyWith(fontSize: 22, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
