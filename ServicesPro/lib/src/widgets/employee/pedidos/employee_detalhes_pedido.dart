import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class EmployeeDetalhesPedido extends StatelessWidget {
  final String label1;
  final String label2;
  final IconData? icon;
  final Color? color;
  final String telefone;
  final String localizacao;
  final String nomeCliente;
  final String? imagemCliente;
  final String categoriaServico;
  final String nomeServico;
  final String descricaoServico;
  final String dataPublicacao;
  final String? observacoesAdicionais;
  final void Function()? onPressedAceitar;
  final void Function()? onPressedRecusar;
  const EmployeeDetalhesPedido({
    super.key,
    required this.label1,
    required this.label2,
    this.icon,
    this.color,
    required this.telefone,
    required this.localizacao,
    required this.nomeCliente,
    this.imagemCliente,
    required this.categoriaServico,
    required this.nomeServico,
    required this.descricaoServico,
    required this.dataPublicacao,
    this.observacoesAdicionais,
    this.onPressedAceitar,
    this.onPressedRecusar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Container(
          width: context.percentWidth(0.95),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TemaSistema().temaSistema(context)
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorsConstants.secundaryColor.withOpacity(
                    0.3,
                  ),
                  radius: 40,
                ),
                Text(
                  nomeCliente,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(icon, color: color, size: 20),
                    SizedBox(width: 4),
                    Text(
                      label1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      label2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: ColorsConstants.azulColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      telefone,
                      style: TextStyle(
                        fontSize: 16,
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorsConstants.azulColor,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      localizacao,
                      style: TextStyle(
                        fontSize: 16,
                        color: TemaSistema().temaSistema(context)
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Informações do serviço",
            style: context.cusotomFontes.black.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: context.percentWidth(0.95),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TemaSistema().temaSistema(context)
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: context.percentWidth(0.9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsConstants.secundaryColor.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      categoriaServico,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorsConstants.azulColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  nomeServico,
                  style: context.cusotomFontes.bold.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  descricaoServico,
                  style: context.cusotomFontes.regular.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor.withOpacity(0.6)
                        : ColorsConstants.letrasColor.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  dataPublicacao,
                  style: context.cusotomFontes.regular.copyWith(
                    color: TemaSistema().temaSistema(context)
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Observações do cliente",
            style: context.cusotomFontes.black.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: context.percentWidth(0.95),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: TemaSistema().temaSistema(context)
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              observacoesAdicionais ??
                  "O cliente não deixou observações adicionais.",
              style: context.cusotomFontes.regular.copyWith(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.primaryColor.withOpacity(0.6)
                    : ColorsConstants.letrasColor.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsConstants.azulColor,
            ),
            onPressed: onPressedAceitar,
            child: Text(
              "Aceitar Pedido",
              style: context.cusotomFontes.bold.copyWith(
                color: ColorsConstants.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
