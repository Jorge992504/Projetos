import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';

class TableDentista extends StatelessWidget {
  final String? nome;
  final String? email;
  final String? cro;
  final String? telefone;
  final String? ativo;
  final bool? isAtivo;
  final Function()? onTap;

  const TableDentista({
    super.key,
    this.nome,
    this.email,
    this.cro,
    this.telefone,
    this.ativo,
    this.isAtivo,
    this.onTap,
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
                    color: isAtivo == false
                        ? ColorsConstants.errorColor
                        : ColorsConstants.appBarColor,
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
                    color: isAtivo == false
                        ? ColorsConstants.errorColor
                        : ColorsConstants.appBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: Text(
                  cro ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isAtivo == false
                        ? ColorsConstants.errorColor
                        : ColorsConstants.appBarColor,
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
                    color: isAtivo == false
                        ? ColorsConstants.errorColor
                        : ColorsConstants.appBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: 25,

                child: InkWell(
                  onTap: onTap,
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: isAtivo == true
                      ? ColorsConstants.errorColor
                      : Colors.blue,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => isAtivo == true
                        ? ColorsConstants.appBarColor.withOpacity(0.12)
                        : ColorsConstants.errorColor.withOpacity(0.12),
                  ),
                  mouseCursor: SystemMouseCursors.click,
                  child: Text(
                    isAtivo == true ? 'Ativo' : 'Inativo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isAtivo == false
                          ? ColorsConstants.errorColor
                          : ColorsConstants.appBarColor,
                    ),
                  ),
                ),
              ),
              // TableCell(
              //   verticalAlignment: TableCellVerticalAlignment.middle,
              //   child: Text(
              //     email ?? "0.0",
              //     textAlign: TextAlign.end,
              //     style: TextStyle(
              //       fontSize: 13,
              //       fontWeight: FontWeight.bold,
              //       color: ColorsConstants.appBarColor,
              //       height: 1,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
