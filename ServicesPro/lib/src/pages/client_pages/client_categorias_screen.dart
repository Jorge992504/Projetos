// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_images.dart';
import 'package:servicespro/src/widgets/custom_container_categorias.dart';

class ClientCategoriasScreen extends StatefulWidget {
  const ClientCategoriasScreen({super.key});

  @override
  State<ClientCategoriasScreen> createState() => _ClientCategoriasScreenState();
}

class _ClientCategoriasScreenState extends State<ClientCategoriasScreen> {
  List<ClientCategoriasModel> categorias = [
    ClientCategoriasModel(
      id: 1,
      nome: "Serviços Domésticos",
      icone: ImageConstants.servicosDomesticos,
    ),
    ClientCategoriasModel(
      id: 2,
      nome: "Reparos e Manutenção",
      icone: ImageConstants.reparosManutencao,
    ),
    ClientCategoriasModel(
      id: 3,
      nome: "Mudança, Transporte e Entregas",
      icone: ImageConstants.mudancaTransporte,
    ),
    ClientCategoriasModel(
      id: 4,
      nome: "Beleza e Estética",
      icone: ImageConstants.belezaEstetica,
    ),
    ClientCategoriasModel(
      id: 5,
      nome: "Tecnologia",
      icone: ImageConstants.tecnologia,
    ),
    ClientCategoriasModel(
      id: 6,
      nome: "Área Pet",
      icone: ImageConstants.autpetomotivo,
    ),
    ClientCategoriasModel(
      id: 7,
      nome: "Fitness e Bem-estar",
      icone: ImageConstants.fitnessBem,
    ),
    ClientCategoriasModel(
      id: 8,
      nome: "Consultoria e Profissionais Especializados",
      icone: ImageConstants.consultorias,
    ),
    ClientCategoriasModel(
      id: 9,
      nome: "Eventos",
      icone: ImageConstants.eventos,
    ),
    ClientCategoriasModel(
      id: 10,
      nome: "Automotivo",
      icone: ImageConstants.automotivo,
    ),
    ClientCategoriasModel(
      id: 11,
      nome: "Reforma e Construção",
      icone: ImageConstants.reformaConstrucao,
    ),
    ClientCategoriasModel(
      id: 12,
      nome: "Segurança",
      icone: ImageConstants.seguranca,
    ),
    ClientCategoriasModel(
      id: 13,
      nome: "Serviços Administrativos",
      icone: ImageConstants.servicosAdministrativos,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias de Serviços')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  ClientCategoriasModel categoriasModel = categorias[index];
                  return CustomContainerCategorias(
                    isDark: isDark,
                    image: categoriasModel.icone ?? "",
                    label: categoriasModel.nome ?? "",
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Rotas.clientPrestadoresCategorias,
                        arguments: {"arguments": categoriasModel.id},
                      );
                    },
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

class ClientCategoriasModel {
  int? id;
  String? nome;
  String? icone;
  ClientCategoriasModel({this.id, this.nome, this.icone});
}
