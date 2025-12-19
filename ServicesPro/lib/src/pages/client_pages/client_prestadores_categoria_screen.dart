// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/avaliacao_client_employee.dart';
import 'package:servicespro/src/widgets/perfil/custom_container_prestador.dart';

class ClientPrestadoresCategoriaScreen extends StatefulWidget {
  const ClientPrestadoresCategoriaScreen({super.key});

  @override
  State<ClientPrestadoresCategoriaScreen> createState() =>
      _ClientPrestadoresCategoriaScreenState();
}

class _ClientPrestadoresCategoriaScreenState
    extends State<ClientPrestadoresCategoriaScreen> {
  int idCategoria = 0;
  List<ClientPrestadoresCategoriaModel> model = [
    ClientPrestadoresCategoriaModel(
      id: 1,
      nome: "Prestador 1",
      categoria: "Categoria 1",
      avalicao: 4,
    ),
    ClientPrestadoresCategoriaModel(
      id: 2,
      nome: "Prestador 2",
      categoria: "Categoria 2",
      avalicao: 3,
    ),
    ClientPrestadoresCategoriaModel(
      id: 3,
      nome: "Prestador 3",
      categoria: "Categoria 3",
      avalicao: 4,
    ),
    ClientPrestadoresCategoriaModel(
      id: 4,
      nome: "Prestador 4",
      categoria: "Categoria 4",
      avalicao: 4,
    ),
    ClientPrestadoresCategoriaModel(
      id: 5,
      nome: "Prestador 5",
      categoria: "Categoria 1",
      avalicao: 4,
    ),
    ClientPrestadoresCategoriaModel(
      id: 6,
      nome: "Prestador 6",
      categoria: "Categoria 1",
      avalicao: 2,
    ),
    ClientPrestadoresCategoriaModel(
      id: 7,
      nome: "Prestador 7",
      categoria: "Categoria 1",
      avalicao: 2,
    ),
    ClientPrestadoresCategoriaModel(
      id: 8,
      nome: "Prestador 8",
      categoria: "Categoria 2",
      avalicao: 2,
    ),
    ClientPrestadoresCategoriaModel(
      id: 9,
      nome: "Prestador 9",
      categoria: "Categoria 2",
      avalicao: 2,
    ),
    ClientPrestadoresCategoriaModel(
      id: 10,
      nome: "Prestador 10",
      categoria: "Categoria 6",
      avalicao: 1,
    ),
  ];
  List<ClientPrestadoresCategoriaModel> sugestoes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        idCategoria = arguments['arguments'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prestadores da Categoria $idCategoria')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Container(
              width: context.percentWidth(0.9),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: TemaSistema().temaSistema(context)
                    ? Theme.of(context).colorScheme.surface
                    : ColorsConstants.telaColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 18,
                decoration: InputDecoration(
                  hintText: 'Busqueda por categoria, Ex: Eletricista',
                  hintStyle: context.cusotomFontes.regular.copyWith(
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                ),
                onChanged: (value) {
                  buscarPrestadorPorCategoria(value);
                },
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: sugestoes.isEmpty ? model.length : sugestoes.length,
                itemBuilder: (context, index) {
                  ClientPrestadoresCategoriaModel categoriaModel =
                      sugestoes.isEmpty ? model[index] : sugestoes[index];
                  return CustomContainerPrestador(
                    isDark: TemaSistema().temaSistema(context),
                    image: Icon(Icons.person),
                    label: categoriaModel.nome ?? "",
                    categoria: categoriaModel.categoria ?? "",
                    avaliacao: AvaliacaoClientEmployee(
                      rating: categoriaModel.avalicao ?? 0,
                      size: 15,
                      activeColor: ServiceColors.reformaConstrucao,
                      inactiveColor: ServiceColors.servicosAdministrativos,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buscarPrestadorPorCategoria(String value) {
    String categoria = value;
    // setState(() {
    //   sugestoes = controller.state.dentistas!
    //       .where((p) => p.nome!.toLowerCase().contains(nome.toLowerCase()))
    //       .toList();
    // });
    setState(() {
      sugestoes = model
          .where(
            (p) => p.categoria!.toLowerCase().contains(categoria.toLowerCase()),
          )
          .toList();
    });
  }
}

class ClientPrestadoresCategoriaModel {
  int? id;
  String? nome;
  String? categoria;
  int? avalicao;
  ClientPrestadoresCategoriaModel({
    this.id,
    this.nome,
    this.categoria,
    this.avalicao,
  });
}
