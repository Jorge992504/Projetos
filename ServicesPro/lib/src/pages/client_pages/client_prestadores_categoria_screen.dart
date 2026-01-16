import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/base/base_state.dart';

import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/client/cliente_controller.dart';
import 'package:servicespro/src/models/client/usuario_prestador/usuario_prestador_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';
import 'package:servicespro/src/states/client/client_state.dart';
import 'package:servicespro/src/widgets/client/finalizar_servico/avaliacao_client_employee.dart';
import 'package:servicespro/src/widgets/perfil/custom_container_prestador.dart';

class ClientPrestadoresCategoriaScreen extends StatefulWidget {
  final int idCategoria;
  const ClientPrestadoresCategoriaScreen({
    super.key,
    required this.idCategoria,
  });

  @override
  State<ClientPrestadoresCategoriaScreen> createState() =>
      _ClientPrestadoresCategoriaScreenState();
}

class _ClientPrestadoresCategoriaScreenState
    extends BaseState<ClientPrestadoresCategoriaScreen, ClienteController> {
  int idCategoria = 0;
  List<UsuarioPrestadorModel> usuarioPrestadorModel = [];
  List<UsuarioPrestadorModel> sugestoes = [];
  String token = '';

  @override
  void initState() {
    super.initState();
    idCategoria = widget.idCategoria;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.buscarPrestadoresCategoria(idCategoria);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prestadores da Categoria')),
      body: BlocConsumer<ClienteController, ClientState>(
        listener: (context, state) async {
          switch (state) {
            case ClientLoading():
              showLoader();
              break;

            case ClientLoaded():
              hideLoader();
              setState(() {
                usuarioPrestadorModel = state.usuarioPrestadorModel;
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
                        ? usuarioPrestadorModel.length
                        : sugestoes.length,
                    itemBuilder: (context, index) {
                      UsuarioPrestadorModel categoriaModel = sugestoes.isEmpty
                          ? usuarioPrestadorModel[index]
                          : sugestoes[index];
                      return CustomContainerPrestador(
                        isDark: TemaSistema().temaSistema(context),
                        image: ClipOval(
                          child: SizedBox(
                            width: 90,
                            height: 50,
                            child: Image.network(
                              categoriaModel.foto!,
                              // width: 56,
                              // height: 56,
                              fit: BoxFit.contain,
                              headers: {
                                "Authorization":
                                    "Bearer ${Provider.of<AuthProvider>(context, listen: false).token}",
                              },
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.person, size: 40),
                            ),
                          ),
                        ),
                        label: categoriaModel.usuarioNome ?? "",
                        categoria: categoriaModel.categoriaNome ?? "",
                        avaliacao: AvaliacaoClientEmployee(
                          rating: categoriaModel.avaliacao == null
                              ? 0
                              : categoriaModel.avaliacao!.floor(),
                          size: 15,
                          activeColor: ServiceColors.reformaConstrucao,
                          inactiveColor: ServiceColors.servicosAdministrativos,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Rotas.chat,
                            arguments: {
                              'usuarioId': categoriaModel.usuarioId,
                              'usuarioNome': categoriaModel.usuarioNome,
                            },
                          );
                        },
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
    //   sugestoes = usuarioPrestadorModel
    //       .where((p) => p.categoriaNome!.toLowerCase().contains(value.toLowerCase()))
    //       .toList();
    // });
    setState(() {
      sugestoes = usuarioPrestadorModel
          .where(
            (p) => p.categoriaNome!.toLowerCase().contains(
              categoria.toLowerCase(),
            ),
          )
          .toList();
    });
  }
}
