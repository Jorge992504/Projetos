import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/models/client/historico_servico/client_timeline_item.dart';

import 'package:servicespro/src/widgets/client/client_historico_servico/card_historico_servico.dart';
import 'package:servicespro/src/widgets/client/client_historico_servico/linha_tempo_historico_servico.dart';
import 'package:servicespro/src/widgets/custom_button.dart';

class ClientHistoricoServicoScreen extends StatefulWidget {
  const ClientHistoricoServicoScreen({super.key});

  @override
  State<ClientHistoricoServicoScreen> createState() =>
      _ClientHistoricoServicoScreenState();
}

class _ClientHistoricoServicoScreenState
    extends State<ClientHistoricoServicoScreen> {
  List<ClientTimelineItem> items = [
    ClientTimelineItem(
      date: '14/01/2024 - 09:30',
      title: 'Serviço Solicitado',
      description: 'Você solicitou o serviço de reparo hidráulico',
      active: true,
    ),
    ClientTimelineItem(
      date: '14/01/2024 - 10:15',
      title: 'Profissional Aceito',
      description: 'Maria Santos aceitou sua solicitação',
      active: true,
    ),
    ClientTimelineItem(
      date: '14/01/2024 - 14:00',
      title: 'Serviço Iniciado',
      description: 'O profissional chegou e iniciou o trabalho',
      active: false,
    ),
    ClientTimelineItem(
      date: '',
      title: 'Serviço Concluído',
      description: 'Aguardando finalização do trabalho',
      active: false,
    ),
  ];
  Color activeColor = ColorsConstants.azulColor;
  Color inactiveColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline do Serviço')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardHistoricoServico(isDark: isDark),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Historico do Serviço",
                    style: context.cusotomFontes.black.copyWith(fontSize: 20),
                  ),
                ),
              ),
              LinhaTempoHistoricoServico(
                items: items,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              //! botao aparece se o status ainda nao esta como finalizado
              CustomButton(
                label: 'Contatar ao prestador',
                onPressed: () {},
                width: context.percentWidth(0.9),
                height: 50,
              ),
              const SizedBox(height: 14),
              CustomButton(
                label: 'Cancelar serviço',
                onPressed: () {},
                width: context.percentWidth(0.9),
                height: 50,
                backgroundColor: WidgetStateProperty.all(
                  ColorsConstants.primaryColor.withOpacity(0.60),
                ),
                style: context.cusotomFontes.bold.copyWith(
                  color: ColorsConstants.letrasColor,
                ),
              ),
              const SizedBox(height: 14),
              //! aparece quando o status é finalizado
              CustomButton(
                label: 'Confirmar finalização do serviço',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Rotas.clientFinalizarServico,
                    (route) => false,
                  );
                },
                width: context.percentWidth(0.9),
                height: 50,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
