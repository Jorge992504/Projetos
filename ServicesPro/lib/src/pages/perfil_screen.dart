import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/avaliacao_client_employee.dart';
import 'package:servicespro/src/widgets/custom_button.dart';
import 'package:servicespro/src/widgets/perfil/card_perfil.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: ColorsConstants.secundaryColor.withOpacity(
                  0.3,
                ),
                radius: 60,
              ),
              const SizedBox(height: 14),
              Text(
                "Nome Cliente/Prestador",
                style: context.cusotomFontes.black.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 5),
              AvaliacaoClientEmployee(
                rating: 4,
                size: 25,
                activeColor: ServiceColors.reformaConstrucao,
                inactiveColor: ServiceColors.servicosAdministrativos,
              ),
              const SizedBox(height: 5),
              Text(
                " Média 4.8 (000 avaliações)",
                style: context.cusotomFontes.light.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Rotas.clientPerfil);
                },
                child: CardPerfil(
                  isDark: isDark,
                  titulo: "Meus Dados",
                  descricao: "Alterar e visualizar meus dados e avaliações.",
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () {},
                child: CardPerfil(
                  isDark: isDark,
                  titulo: "Ajuda e Suporte",
                  descricao: "Central de atendimento.",
                  iconeTitulo: Icon(
                    Icons.help_outline,
                    size: 25,
                    color: ServiceColors.fitnessBem,
                  ),
                  backgroundColor: ServiceColors.mudancaTransporte.withOpacity(
                    0.15,
                  ),
                ),
              ),
              const SizedBox(height: 34),

              CustomButton(
                label: "Sair da Conta",
                style: context.cusotomFontes.bold.copyWith(
                  color: ColorsConstants.iconeErrorColor,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                width: context.percentWidth(1),
                backgroundColor: WidgetStateProperty.all(
                  ColorsConstants.iconeErrorColor.withOpacity(0.40),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
