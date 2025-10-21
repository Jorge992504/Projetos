import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';

class TableServicos extends StatelessWidget {
  final String? title;
  final String? valor;
  const TableServicos({super.key, this.title, this.valor});

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
                  title ?? "",
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
                  'R\$ ${valor ?? "0.0"}',
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
