import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/employee/home/container_servicos_disponiveis.dart';

class EmployeeServicosScreen extends StatefulWidget {
  const EmployeeServicosScreen({super.key});

  @override
  State<EmployeeServicosScreen> createState() => _EmployeeServicosScreenState();
}

class _EmployeeServicosScreenState extends State<EmployeeServicosScreen> {
  int isSelect = 1;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Serviços Disponíveis",
          style: context.cusotomFontes.black.copyWith(
            fontSize: 20,
            color: ColorsConstants.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsConstants.azulColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Container(
              width: context.percentWidth(0.95),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Theme.of(context).colorScheme.surface
                    : ColorsConstants.telaColor,
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
              child: SizedBox(
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: context.percentHeight(0.6),
              width: context.percentWidth(0.9),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ContainerServicosDisponiveis(
                        categoria: "Eletrica",
                        servico: "Instalação de painel elétrico residencial",
                        descricaoServico:
                            "Descrição detalhada do serviço a ser realizado, incluindo requisitos específicos e expectativas do cliente.",
                        onPressedDetalhes: () {},
                      ),
                      const SizedBox(height: 14),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void isSelected(int index) {
    setState(() {
      isSelect = index;
    });
  }
}
