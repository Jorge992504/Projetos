import 'dart:async';
import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:faltou_nada/app/src/pages/home/home_controller.dart';
import 'package:faltou_nada/app/src/pages/home/home_state.dart';
import 'package:faltou_nada/app/src/pages/home/widgets/home_item.dart';
import 'package:faltou_nada/app/src/pages/home/widgets/home_text_field.dart';
import 'package:faltou_nada/app/src/widgets/custom_bar_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  bool empty = false;
  List<ProductModel> sugestoes = [];
  late TextEditingController pesquisaController;
  late FocusNode pesquisaFocus;
  Timer? timer;
  String version = '';
  String url = '';

  @override
  void initState() {
    super.initState();
    pesquisaController = TextEditingController();
    pesquisaFocus = FocusNode();

    timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      context.read<HomeController>().refresh();
    });
    // FocusScope.of(context).unfocus();
    versao();
  }

  @override
  void dispose() {
    super.dispose();
    pesquisaController.dispose();
    pesquisaFocus.dispose();
  }

  @override
  void onReady() async {
    super.onReady();
    await controller.findProduct();
    await controller.findProductFromUser();
    await controller.refresh();
  }

  @override
  Widget build(BuildContext context) {
    String nome = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userModel.name;
    String email = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userModel.email;
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

    return BlocConsumer<HomeController, HomeState>(
      listener: (context, state) {
        state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          loaded: hideLoader,
          failure: () {
            showError(state.errorMessage ?? 'INTERNAL_ERROR');
            hideLoader();
          },
          success: hideLoader,
        );
      },
      builder: (context, state) {
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
                            fontSize: 14,
                            color: ColorsConstants.fundo,
                          ),
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
                          Icons.attach_money_outlined,
                          size: 20,
                          color: ColorsConstants.appBar,
                        ),
                        title: Text(
                          "Registrar valores",
                          style: context.fontesLetras.textThin.copyWith(
                            fontSize: 14,
                            color: ColorsConstants.appBar,
                          ),
                        ),
                        onTap: () async {
                          bool result = await openCamera();
                          if (result) {
                            await controller.enviarUrl(url);
                          }
                        },
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
                          Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Rotas.login,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    right: 12,
                    child: Text(
                      version,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
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
                homeController: controller,
                sugestoes: sugestoes,
                controller: pesquisaController,
                focusNode: pesquisaFocus,
                onPressed: saveProductForName,
                onTap: () {
                  setState(() {
                    empty = !empty;
                  });
                },
                empty: empty,
                onChanged: (value) => buscarSuggestoes(value),
              ),
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.red.withValues(alpha: 0.1),
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              //   ),
              //   child: Row(
              //     children: [
              //       const Icon(
              //         Icons.error_outline_rounded,
              //         color: Colors.red,
              //         size: 24,
              //       ),
              //       const SizedBox(width: 12),
              //       Flexible(
              //         child: Text(
              //           url,
              //           style: context.fontesLetras.textRegular.copyWith(
              //             color: Colors.red,
              //             fontWeight: FontWeight.w500,
              //             overflow: TextOverflow.visible,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 16,
                      children: (state.productUser ?? [])
                          .map(
                            (product) => HomeItem(
                              product: product,
                              onTap: () {
                                deleteProductFromUser(product.id);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void buscarSuggestoes(String value) {
    if (value.isEmpty) {
      setState(() {
        sugestoes = [];
      });
    } else {
      setState(() {
        sugestoes = controller.state.productModel!
            .where((p) => p.nome.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> deleteProductFromUser(int productId) async {
    bool result = await controller.deleteProductFromUser(productId);
    if (result) {
      await controller.refresh();
    }
  }

  Future<void> saveProductForName() async {
    String productName = pesquisaController.text;
    if (productName.isNotEmpty) {
      bool result = await controller.saveProductForName(productName);
      if (result) {
        pesquisaFocus.unfocus();
        await controller.refresh();
      }
    } else {
      showError('Informe um produto');
      pesquisaFocus.requestFocus();
    }
  }

  Future<void> versao() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  Future<bool> openCamera() async {
    var codeBar = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BarcodeScannerSimple()),
    );
    if (codeBar != null) {
      setState(() {
        url = codeBar;
      });
      return true;
    } else {
      return false;
    }
  }
}
