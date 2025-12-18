import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/client/client_pedido/card_pedidos.dart';
import 'package:servicespro/src/widgets/client/client_pedido/filtros_pedido.dart';

class ClientPedidosScreen extends StatefulWidget {
  const ClientPedidosScreen({super.key});

  @override
  State<ClientPedidosScreen> createState() => _ClientPedidosScreenState();
}

class _ClientPedidosScreenState extends State<ClientPedidosScreen> {
  int isSelec = 1;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            FiltrosPedido(
              onPressedAbertos: () {
                isSelected(1);
              },
              onPressedEmAndamento: () {
                isSelected(2);
              },
              onPressedFinalizados: () {
                isSelected(3);
              },
              isSelec: isSelec,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: context.percentWidth(1),
              height: context.percentHeight(0.65),
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return CardPedidos(
                    isDark: isDark,
                    statusPedido: "ANDAMENTO",
                    onPressedAcompanhar: () {},
                    onPressedCancelar: () {},
                    onPressedAcompanharProgresso: () {
                      Navigator.of(context).pushNamed(
                        Rotas.clientHistoricoServico,
                        arguments: {"servicoModel": 1},
                      );
                    },
                    onPressedVerDetalhes: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void isSelected(int value) {
    setState(() {
      isSelec = value;
    });
  }
}
