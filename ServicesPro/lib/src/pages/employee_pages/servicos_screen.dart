import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/employee/servicos/card_servico.dart';

class ServicosScreen extends StatefulWidget {
  const ServicosScreen({super.key});

  @override
  State<ServicosScreen> createState() => _ServicosScreenState();
}

class _ServicosScreenState extends State<ServicosScreen> {
  int isSelect = 1;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        children: [
          Container(
            width: context.percentWidth(0.9),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(context).colorScheme.surface
                  : ColorsConstants.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 18,
              decoration: InputDecoration(
                hintText: 'Buscar serviços, ex: Elétirca',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorsConstants.azulColor,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    color: isSelect == 1
                        ? ColorsConstants.secundaryColor.withOpacity(0.25)
                        : Theme.of(context).colorScheme.surface,
                  ),
                  child: TextButton(
                    onPressed: () {
                      isSelected(1);
                    },
                    child: Text(
                      "Preços",
                      style: context.cusotomFontes.regular.copyWith(
                        color: isSelect == 1 && isDark
                            ? ColorsConstants.primaryColor
                            : isSelect == 1 && !isDark
                            ? ColorsConstants.letrasColor
                            : isSelect != 1 && !isDark
                            ? ColorsConstants.letrasColor
                            : ColorsConstants.azulColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  // width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorsConstants.azulColor,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    color: isSelect == 2
                        ? ColorsConstants.secundaryColor.withOpacity(0.25)
                        : Theme.of(context).colorScheme.surface,
                  ),
                  child: TextButton(
                    onPressed: () {
                      isSelected(2);
                    },
                    child: Text(
                      "Categoria",
                      style: context.cusotomFontes.regular.copyWith(
                        color: isSelect == 2 && isDark
                            ? ColorsConstants.primaryColor
                            : isSelect == 2 && !isDark
                            ? ColorsConstants.letrasColor
                            : isSelect != 2 && !isDark
                            ? ColorsConstants.letrasColor
                            : ColorsConstants.azulColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  // width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorsConstants.azulColor,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    color: isSelect == 3
                        ? ColorsConstants.secundaryColor.withOpacity(0.25)
                        : Theme.of(context).colorScheme.surface,
                  ),
                  child: TextButton(
                    onPressed: () {
                      isSelected(3);
                    },
                    child: Text(
                      "Prioridade",
                      style: context.cusotomFontes.regular.copyWith(
                        color: isSelect == 3 && isDark
                            ? ColorsConstants.primaryColor
                            : isSelect == 3 && !isDark
                            ? ColorsConstants.letrasColor
                            : isSelect != 3 && !isDark
                            ? ColorsConstants.letrasColor
                            : ColorsConstants.azulColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed(Rotas.criarPedido);
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: context.percentHeight(0.6),
            width: context.percentWidth(0.85),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CardServico(
                  categoria: "Serviços Domésticos",
                  titulo: "Limpeça de apartamento",
                  preco: 'R\$ 00.00 - 00.00',
                  idCategoria: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void isSelected(int index) {
    setState(() {
      isSelect = index;
    });
  }
}
