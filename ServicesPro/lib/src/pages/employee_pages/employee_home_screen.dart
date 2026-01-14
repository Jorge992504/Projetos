import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/src/models/usuario_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/widgets/employee/home/container_avaliacao_trabalhos.dart';
import 'package:servicespro/src/widgets/employee/home/container_servicos_disponiveis.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  UsuarioModel usuarioModel = UsuarioModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        usuarioModel = Provider.of<AuthProvider>(
          context,
          listen: false,
        ).usuarioModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bem-vindo, ${usuarioModel.nome}!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    splashRadius: 5,

                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundColor: ColorsConstants.secundaryColor
                          .withOpacity(1),
                      child: Icon(
                        Icons.notifications_none,
                        size: 25,
                        color: ColorsConstants.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ContainerAvaliacaoTrabalhos(
                      label1: usuarioModel.avalicao.toString(),
                      label2: 'De avaliação',
                      icon: Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ContainerAvaliacaoTrabalhos(
                      label1: usuarioModel.qtdeServicos.toString(),
                      label2: 'Serviços concluídos',
                      icon: Icons.home_repair_service_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: ColorsConstants.azulColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Serviçõs em destaque",
                  style: context.cusotomFontes.bold.copyWith(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ver todos",
                    style: context.cusotomFontes.medium.copyWith(
                      color: ColorsConstants.secundaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Center(
                        child: ContainerServicosDisponiveis(
                          categoria: "Eletrica",
                          servico: "Instalação de painel elétrico residencial",
                          descricaoServico:
                              "Descrição detalhada do serviço a ser realizado, incluindo requisitos específicos e expectativas do cliente.",
                          onPressedDetalhes: () {
                            Navigator.of(
                              context,
                            ).pushNamed(Rotas.employeeDetalhesServico);
                          },
                        ),
                      ),
                      SizedBox(height: 16),
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
}
