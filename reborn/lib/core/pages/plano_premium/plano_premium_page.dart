import 'package:flutter/material.dart';

import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

import 'package:reborn/core/pages/plano_premium/plano_controller.dart';

import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/base_state.dart';
import 'package:reborn/core/widgets/reborn_app_bar.dart';

class PlanoPremiumPage extends StatefulWidget {
  const PlanoPremiumPage({super.key});

  @override
  State<PlanoPremiumPage> createState() => _PlanoPremiumPageState();
}

class _PlanoPremiumPageState
    extends BaseState<PlanoPremiumPage, PlanoController> {
  final formKey = GlobalKey<FormState>();
  final endereco = TextEditingController();
  final cpf = TextEditingController();
  int? pyamentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RebornAppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20, left: 20),
            width: context.screenLargura,
            height: 50,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black, width: 0.3),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Plano premium",
                style: context.textEstilo.textBold.copyWith(fontSize: 25),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20),
            width: context.screenMetadeLargura(0.9),
            height: 50,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black, width: 0.3),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Melhoras oferecidas",
                style: context.textEstilo.textMedium.copyWith(fontSize: 14),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            // margin: const EdgeInsets.only(top: 5),
            width: context.screenMetadeLargura(0.9),
            height: 50,
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 0.3),
                color: Colors.grey[300]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "1º melhora",
                style: context.textEstilo.textLight.copyWith(fontSize: 14),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            width: context.screenMetadeLargura(0.9),
            height: 50,
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 0.3),
                color: Colors.grey[300]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "2º melhora",
                style: context.textEstilo.textLight.copyWith(fontSize: 14),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            width: context.screenMetadeLargura(0.9),
            height: 50,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black, width: 0.3),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "3º melhora",
                style: context.textEstilo.textLight.copyWith(fontSize: 14),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 40),
            width: context.screenMetadeLargura(0.9),
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Preço do plano",
                        style:
                            context.textEstilo.textBold.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        r"R$ 0.0 ",
                        style: context.textEstilo.textBold
                            .copyWith(fontSize: 14, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  // margin: const EdgeInsets.only(top: 5),
                  width: context.screenMetadeLargura(0.8),
                  height: 70,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black, width: 0.3),
                  // ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "O plano será valido por 3 meses, despois deve ser renovado e será proporcionado um plano novo, valor do plano pode ser reajustado",
                      style:
                          context.textEstilo.textLight.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: context.screenMetadeLargura(0.8),
            height: 50,
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(Rotas.confirmarpagamento);
              },
              child: const Row(
                children: [
                  Text("Avanzar para o pagamento"),
                  SizedBox(
                    width: 105,
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
