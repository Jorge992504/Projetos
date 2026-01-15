// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicespro/core/ui/base/base_state.dart';

import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/client/cliente_controller.dart';
import 'package:servicespro/src/models/client/usuario_prestador/usuario_prestador_model.dart';
import 'package:servicespro/src/states/client/client_state.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/avaliacao_client_employee.dart';
import 'package:servicespro/src/widgets/perfil/custom_container_prestador.dart';

class ClientPrestadoresCategoriaScreen extends StatefulWidget {
  const ClientPrestadoresCategoriaScreen({super.key});

  @override
  State<ClientPrestadoresCategoriaScreen> createState() =>
      _ClientPrestadoresCategoriaScreenState();
}

class _ClientPrestadoresCategoriaScreenState
    extends BaseState<ClientPrestadoresCategoriaScreen, ClienteController> {
  int idCategoria = 0;
  List<UsuarioPrestadorModel> model = [];
  List<UsuarioPrestadorModel> sugestoes = [];

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
      await controller.buscarPrestadoresCategoria(idCategoria);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prestadores da Categoria $idCategoria')),
      body: BlocConsumer<ClienteController, ClientState>(
        listener: (context, state) async {
          switch (state) {
            case ClientLoading():
              showLoader();
              break;

            case ClientLoaded():
              hideLoader();
              setState(() {
                model = state.usuarioPrestadorModel;
              });
              break;

            case ClientFailure(:final errorMessage):
              hideLoader();
              showError(
                errorMessage!.isNotEmpty
                    ? errorMessage
                    : 'Login ou senha inválidos',
              );
              break;

            case ClientSuccess():
              hideLoader();
              showSuccess('Cadastro realizado com sucesso');

              break;

            case ClientInitial():
              hideLoader();
              break;
          }
        },
        builder: (context, state) {
          return Center(
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
                    itemCount: sugestoes.isEmpty
                        ? model.length
                        : sugestoes.length,
                    itemBuilder: (context, index) {
                      UsuarioPrestadorModel categoriaModel = sugestoes.isEmpty
                          ? model[index]
                          : sugestoes[index];
                      return CustomContainerPrestador(
                        isDark: TemaSistema().temaSistema(context),
                        image: Icon(Icons.person),
                        label: categoriaModel.categoriaNome ?? "",
                        categoria: categoriaModel.usuarioNome ?? "",
                        avaliacao: AvaliacaoClientEmployee(
                          rating:
                              int.tryParse(
                                categoriaModel.avaliaca.toString(),
                              ) ??
                              0,
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
          );
        },
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
            (p) => p.categoriaNome!.toLowerCase().contains(
              categoria.toLowerCase(),
            ),
          )
          .toList();
    });
  }
}
