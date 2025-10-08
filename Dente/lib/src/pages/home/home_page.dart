import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:dente/src/widgets/custom_calendario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    EmpresaModel empresaModel = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).empresaModel;

    String getNome() {
      if (empresaModel.nomeClinica!.isEmpty) {
        return "";
      }
      String nomefinal = "";
      List<String> nomes = empresaModel.nomeClinica!.split(" ");
      if (nomes.length > 1) {
        nomefinal = '${nomes[0][0]}${nomes[nomes.length - 1][0]}';
      } else {
        try {
          nomefinal = nomes[0].substring(0, 2);
        } catch (e) {
          nomefinal = empresaModel.nomeClinica!;
        }
      }
      return nomefinal;
    }

    //!criar um refresh no controller

    //! lista para simular os agendamentos
    final agendamentos = [
      AgendamentosModelResponse(data: DateTime(2025, 10, 8), id: 1),
      AgendamentosModelResponse(data: DateTime(2025, 10, 8), id: 2),
      AgendamentosModelResponse(data: DateTime(2025, 10, 10), id: 3),
      AgendamentosModelResponse(data: DateTime(2025, 10, 15), id: 4),
      AgendamentosModelResponse(data: DateTime(2025, 10, 15), id: 5),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos')),
      endDrawer: SafeArea(
        child: Drawer(
          backgroundColor: ColorsConstants.primaryColor,
          child: Stack(
            children: [
              ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      empresaModel.nomeClinica ?? "",
                      style: context.cusotomFontes.textBoldItalic.copyWith(
                        color: ColorsConstants.primaryColor,
                        height: 1,
                      ),
                    ),
                    accountEmail: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          empresaModel.emailClinica ?? "",
                          style: context.cusotomFontes.textRegular.copyWith(
                            color: ColorsConstants.primaryColor,
                            height: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(Rotas.editarEmpresa);
                          },
                          child: Text(
                            "Editar",
                            style: context.cusotomFontes.textItalic.copyWith(
                              fontSize: 13,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: ColorsConstants.appBarColor,
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 40, // ou maxRadius
                      backgroundColor: ColorsConstants.focusColor,
                      backgroundImage: empresaModel.foto != null
                          ? NetworkImage(empresaModel.foto!)
                          : null,

                      child: empresaModel.foto == null ? Text(getNome()) : null,
                    ),
                    currentAccountPictureSize: const Size.square(70),
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstants.logout,
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                    title: Text("Sair", style: context.cusotomFontes.textBold),
                    onTap: () async {
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).logout();
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(Rotas.login, (route) => false);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, tamanho) {
          return Column(
            children: [CustomCalendario(agendamentos: agendamentos)],
          );
        },
      ),
    );
  }
}
