import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/response/precos_model_response.dart';
import 'package:dente/src/pages/plano/plano_controller.dart';
import 'package:dente/src/pages/plano/plano_payment_page.dart';
import 'package:dente/src/pages/plano/plano_state.dart';
import 'package:dente/src/pages/plano/widgets/plano_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PlanoPage extends StatefulWidget {
  const PlanoPage({super.key});

  @override
  State<PlanoPage> createState() => _PlanoPageState();
}

class _PlanoPageState extends BaseState<PlanoPage, PlanoController> {
  String respostaTexto =
      ""; // <-- aqui guardamos o retorno para mostrar no Text

  List<PrecosModelResponse> precos = [];

  String token = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;

      final resultado = await controller.buscarPrecos();
      setState(() {
        precos = resultado;
        token = arguments['token'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: BlocConsumer<PlanoController, PlanoState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');

              hideLoader();
            },
            success: () {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Escolha seu plano\npara continuar usando o sistema.',
                      style: context.cusotomFontes.textBold.copyWith(
                        color: ColorsConstants.appBarColor,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: 1000,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: precos.map((plano) {
                      final precoFinal =
                          plano.promocao == true && plano.precoPromocao! > 0
                          ? plano.precoPromocao
                          : plano.preco;

                      return PlanoCard(
                        withAlpha: plano.plano?.toLowerCase() == "basico"
                            ? 150
                            : plano.plano?.toLowerCase() == "pro"
                            ? 200
                            : 255,

                        planoTitle: "Plano ${plano.plano}",
                        planoPrice: "R\$ ${precoFinal?.toStringAsFixed(2)}/mês",

                        // Descrições vindas da API ↓↓↓↓↓
                        planoDescription1: plano.funcionalidades!.length > 0
                            ? "- ${plano.funcionalidades?[0]}"
                            : "",
                        planoDescription2: plano.funcionalidades!.length > 1
                            ? "- ${plano.funcionalidades?[1]}"
                            : "",
                        planoDescription3: plano.funcionalidades!.length > 2
                            ? "- ${plano.funcionalidades?[2]}"
                            : "",
                        planoDescription4: plano.funcionalidades!.length > 3
                            ? "- ${plano.funcionalidades?[3]}"
                            : "",

                        onPressed: () {
                          navegarPaymentPlano(
                            plano: plano.plano,
                            preco: precoFinal?.toStringAsFixed(2),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(LogosCartoes.visa, width: 40),
                    const SizedBox(width: 20),
                    Image.asset(LogosCartoes.mastercard, width: 40),
                    const SizedBox(width: 20),
                    Image.asset(LogosCartoes.pix, width: 40),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void navegarPaymentPlano({
    String? plano,
    String? preco,
    String? token,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<PlanoController>(context, listen: false),
          child: PlanoPaymentPage(plano: plano, preco: preco, token: token),
        ),
      ),
    );
  }

  num? getPrecoPorPlano(String nomePlano) {
    final item = precos.firstWhere(
      (p) => p.plano?.toLowerCase() == nomePlano.toLowerCase(),
      orElse: () => PrecosModelResponse(
        preco: 0,
        plano: nomePlano,
        desconto: 0,
        promocao: false,
        precoPromocao: 0,
        funcionalidades: [],
      ),
    );

    // Se tiver promoção, mostra o preço promocional
    if (item.promocao == true && item.precoPromocao! > 0) {
      return item.precoPromocao;
    }

    return item.preco;
  }
}
