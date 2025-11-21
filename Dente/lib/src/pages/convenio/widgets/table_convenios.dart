import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';

class TableConvenios extends StatelessWidget {
  final String? parceiro;
  final String? tratamento;
  final String? valor;
  const TableConvenios({super.key, this.valor, this.parceiro, this.tratamento});

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
                  parceiro ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: Text(
                  tratamento ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstants.appBarColor,
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  '$valor%',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ColorsConstants.appBarColor,
                    height: 1,
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
