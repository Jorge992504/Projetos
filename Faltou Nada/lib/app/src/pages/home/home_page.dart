import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/pages/home/home_controller.dart';
import 'package:faltou_nada/app/src/pages/home/home_state.dart';
import 'package:faltou_nada/app/src/pages/home/widgets/home_item.dart';
import 'package:faltou_nada/app/src/pages/home/widgets/home_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() async {
    super.onReady();
    await controller.findProduct();
  }

  @override
  Widget build(BuildContext context) {
    String nome =
        Provider.of<AuthProvider>(context, listen: false).userModel.name;
    String email =
        Provider.of<AuthProvider>(context, listen: false).userModel.email;
    String getNome() {
      if (nome.isEmpty) {
        return "";
      }
      String nomefinal = "";
      List<String> nomes = nome.split(" ");
      if (nomes.length > 1) {
        nomefinal = '${nomes[0][0]}${nomes[nomes.length - 1][0]}';
      } else {
        try {
          nomefinal = nomes[0].substring(0, 2);
        } catch (e) {
          nomefinal = nome;
        }
      }
      return nomefinal;
    }

    return BlocConsumer<HomeController, HomeState>(listener: (context, state) {
      state.status.matchAny(
        any: hideLoader,
        loading: showLoader,
        loaded: hideLoader,
        failure: () {
          showError(state.errorMessage ?? 'Login ou senha inválidos');
          hideLoader();
        },
        success: hideLoader,
      );
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorsConstants.fundoCard),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Faltou nada né',
                style: context.fontesLetras.textThin.copyWith(
                  fontSize: 20,
                  color: ColorsConstants.fundoCard,
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  ImageConstants.piscada16,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        endDrawer: SafeArea(
          child: Drawer(
            backgroundColor: ColorsConstants.textos,
            child: Stack(
              children: [
                ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        nome.toUpperCase(),
                        style: context.fontesLetras.textRegular.copyWith(
                            fontSize: 14, color: ColorsConstants.fundo),
                      ),
                      accountEmail: Text(
                        email,
                        style: context.fontesLetras.textRegular.copyWith(
                          fontSize: 14,
                          color: ColorsConstants.fundo,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: ColorsConstants.appBar,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: ColorsConstants.fundoCard,
                        child: Text(
                          getNome(),
                          style: context.fontesLetras.textThin.copyWith(
                            fontSize: 25,
                            color: ColorsConstants.appBar,
                          ),
                        ),
                      ),
                      currentAccountPictureSize: const Size.square(60),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout_sharp,
                        size: 20,
                        color: ColorsConstants.appBar,
                      ),
                      title: Text(
                        "Sair",
                        style: context.fontesLetras.textThin.copyWith(
                          fontSize: 14,
                          color: ColorsConstants.appBar,
                        ),
                      ),
                      onTap: () async {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Rotas.login,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                const Positioned(
                  bottom: 10,
                  right: 12,
                  child: Text(
                    'versao',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeTextField(
              sugestoes: state.productModel ?? [],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (state.productModel ?? [])
                      .map((product) => HomeItem(product: product))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
