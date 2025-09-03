import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/models/dashboard_model.dart';
import 'package:faltou_nada/app/src/pages/dashboard/widgets/dashboard_cabecalho.dart';
import 'package:faltou_nada/app/src/pages/dashboard/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String? dataTime;
  final String? vlTotal;
  final String? vlProd;
  final double? width;
  final double? height;
  final bool isExpanded;
  final Function()? onTap;
  final List<DashboardItensModel>? itens;
  const DashboardCard({
    super.key,
    this.dataTime,
    this.width,
    this.height,
    this.vlTotal,
    this.vlProd,
    required this.isExpanded,
    this.onTap,
    this.itens,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? context.percentWidth(5),
        height: height ?? 130,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: ColorsConstants.fundoCard,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataTime ?? "",
                  style: context.fontesLetras.textRegular.copyWith(
                    color: ColorsConstants.appBar,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: !isExpanded,
                  child: Text(
                    vlTotal ?? "",
                    style: context.fontesLetras.textRegular.copyWith(
                      color: ColorsConstants.appBar,
                      fontSize: 16,
                    ),
                  ),
                ),
                Visibility(
                  visible: isExpanded,
                  child: const Divider(
                    color: ColorsConstants.appBar,
                    height: 1,
                  ),
                ),
                Visibility(
                  visible: isExpanded,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: DashboardCabecalho(),
                  ),
                ),
                Visibility(
                  visible: isExpanded,
                  child: Expanded(
                    // aqui o ListView ocupa o restante do card
                    child: ListView.builder(
                      itemCount: itens?.length,
                      itemBuilder: (context, index) {
                        final item = itens![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: DashboardItem(item: item),
                        );
                      },
                    ),
                  ),
                ),
                isExpanded
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: isExpanded,
                              child: Text(
                                vlTotal ?? "",
                                style: context.fontesLetras.textRegular
                                    .copyWith(
                                      color: ColorsConstants.appBar,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                            InkWell(
                              onTap: onTap,
                              child: Icon(
                                isExpanded
                                    ? Icons.close
                                    : Icons.arrow_downward_sharp,
                                color: ColorsConstants.appBar,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: onTap,
                          child: Icon(
                            isExpanded
                                ? Icons.close
                                : Icons.arrow_downward_sharp,
                            color: ColorsConstants.appBar,
                            size: 20,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
