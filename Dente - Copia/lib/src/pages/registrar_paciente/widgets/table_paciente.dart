import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';

class TablePaciente extends StatelessWidget {
  final String? nome;
  final String? email;
  final String? telefone;
  final String? cpf;
  final Function()? onTap;

  const TablePaciente({
    super.key,
    this.nome,
    this.email,
    this.telefone,
    this.onTap,
    this.cpf,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Table(
        columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
        children: [
          TableRow(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.5)),
            ),
            children: [
              SizedBox(
                height: 35,
                child: Text(
                  nome ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),

              SizedBox(
                height: 35,
                child: Text(
                  cpf ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: Text(
                  telefone ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: Text(
                  email ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
