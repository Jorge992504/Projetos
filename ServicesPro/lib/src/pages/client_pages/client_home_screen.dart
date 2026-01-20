import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/custom_images.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/controllers/client/cliente_controller.dart';
import 'package:servicespro/src/pages/client_pages/client_prestadores_categoria_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
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
      id: 11,
      nome: "Reforma e Construção",
      icone: ImageConstants.reformaConstrucao,
    ),
    ClientCategoriasModel(
      id: 12,
      nome: "Segurança",
      icone: ImageConstants.seguranca,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: context.percentWidth(1),
            height: 170,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Encontre profissionais\nconfiáveis.",
                      style: context.cusotomFontes.bold.copyWith(
                        fontSize: 20,
                        color: ColorsConstants.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Conecte-se com especialistas verificados na sua região.",
                      overflow: TextOverflow.visible,
                      style: context.cusotomFontes.medium.copyWith(
                        fontSize: 13,
                        color: ColorsConstants.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 40, bottom: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categorias de Serviços",
              style: context.cusotomFontes.extraBold.copyWith(fontSize: 22),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   Rotas.clientPrestadoresCategorias,
                //   arguments: {"arguments": 1},
                // );
                navegarEntrePaginas(1);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.servicosDomesticos,
                        width: 50,
                      ),
                    ),
                    Text(
                      "Serviços\nDomésticos",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 2},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.reparosManutencao,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Reparos e\nManutenção",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 11},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.reformaConstrucao,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Reforma e\nConstrução",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 5},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(ImageConstants.tecnologia, width: 50),
                    ),
                    Text(
                      "Tecnologia",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 4},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.belezaEstetica,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Beleza e\nEstética",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 7},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.fitnessBem,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Fitness e\nBem-estar",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 12},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(ImageConstants.seguranca, width: 50),
                    ),
                    Text(
                      "Segurança",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Rotas.clientPrestadoresCategorias,
                  arguments: {"arguments": 6},
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.autpetomotivo,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Área Pet",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Rotas.clientCategoriasServicos);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: isDark
                        ? ColorsConstants.primaryColor
                        : ColorsConstants.letrasColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageConstants.mais,
                        width: 50,
                        fit: BoxFit.contain,
                        color: isDark
                            ? ColorsConstants.primaryColor
                            : ColorsConstants.letrasColor,
                      ),
                    ),
                    Text(
                      "Mais",
                      textAlign: TextAlign.center,
                      style: context.cusotomFontes.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void navegarEntrePaginas(int? idCategoria) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<ClienteController>(context, listen: false),
          child: ClientPrestadoresCategoriaScreen(
            idCategoria: idCategoria ?? 0,
          ),
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
