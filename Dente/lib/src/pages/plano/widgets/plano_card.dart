import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:flutter/material.dart';

class PlanoCard extends StatelessWidget {
  final int? withAlpha;
  final String? planoTitle;
  final String? planoPrice;
  final String? planoDescription1;
  final String? planoDescription2;
  final String? planoDescription3;
  final String? planoDescription4;
  final String? planoDescription5;
  final String? planoDescription6;
  final String? planoDescription7;
  final String? planoDescription8;
  final String? planoDescription9;
  final String? planoDescription10;
  final void Function()? onPressed;

  const PlanoCard({
    super.key,
    this.withAlpha,
    this.planoTitle,
    this.planoPrice,
    this.planoDescription1,
    this.planoDescription2,
    this.planoDescription3,
    this.planoDescription4,
    this.planoDescription5,
    this.planoDescription6,
    this.planoDescription7,
    this.planoDescription8,
    this.planoDescription9,
    this.planoDescription10,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 270,
        height: context.percentHeight(0.6),
        padding: const EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
          color: ColorsConstants.appBarColor.withAlpha(
            withAlpha ?? 0,
          ), // azul do card
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Topo branco
            Container(
              width: 240,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorsConstants.primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    planoTitle ?? "",
                    style: context.cusotomFontes.textBold.copyWith(
                      fontSize: 20,
                      color: ColorsConstants.appBarColor.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    planoPrice ?? "",
                    style: context.cusotomFontes.textBold.copyWith(
                      fontSize: 28,
                      color: ColorsConstants.appBarColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Lista de benefícios
            Text(
              planoDescription1 ?? "",
              style: TextStyle(
                color: ColorsConstants.primaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              planoDescription2 ?? "",
              style: TextStyle(
                color: ColorsConstants.primaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              planoDescription3 ?? "",
              style: TextStyle(
                color: ColorsConstants.primaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              planoDescription4 ?? "",
              style: TextStyle(
                color: ColorsConstants.primaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

            // const SizedBox(height: 12),
            // Text(
            //   planoDescription5 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   planoDescription6 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   planoDescription7 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   planoDescription8 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   planoDescription9 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   planoDescription10 ?? "",
            //   style: TextStyle(
            //     color: ColorsConstants.primaryColor,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 40),

            // Botão
            const Spacer(),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConstants.primaryColor,
                foregroundColor: ColorsConstants.appBarColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                "ASSINAR AGORA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
