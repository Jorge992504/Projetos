import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/src/widgets/employee/pedidos/employee_card_pedidos.dart';
import 'package:servicespro/src/widgets/employee/pedidos/employee_filtro_pedidos.dart';

class EmployeePedidosScreen extends StatefulWidget {
  const EmployeePedidosScreen({super.key});

  @override
  State<EmployeePedidosScreen> createState() => _EmployeePedidosScreenState();
}

class _EmployeePedidosScreenState extends State<EmployeePedidosScreen> {
  int isSelec = 1;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Historico de Pedidos",
          style: TextStyle(color: ColorsConstants.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: ColorsConstants.azulColor,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
        child: Center(
          child: Column(
            children: [
              EmployeeFiltroPedidos(
                onPressedCancelados: () {
                  isSelected(3);
                },
                onPressedEmAndamento: () {
                  isSelected(1);
                },
                onPressedFinalizados: () {
                  isSelected(2);
                },
                isSelec: isSelec,
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return EmployeeCardPedidos(
                      isDark: isDark,
                      statusPedido: "ANDAMENTO",
                      onPressedFinalizar: () {},
                      onPressedChat: () {
                        Navigator.of(context).pushNamed(Rotas.chat);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
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
