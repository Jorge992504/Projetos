import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/servicos_model.dart';
import 'package:dente/src/pages/servicos/servicos_controller.dart';
import 'package:dente/src/pages/servicos/servicos_state.dart';
import 'package:dente/src/pages/servicos/widgets/table_servicos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  State<ServicosPage> createState() => _ServicosPageState();
}

class _ServicosPageState extends BaseState<ServicosPage, ServicosController> {
  final formKey = GlobalKey<FormState>();

  final servicoController = TextEditingController();
  final valorController = TextEditingController();

  final servicoFocus = FocusNode();
  final valorFocus = FocusNode();

  bool isPesquisa = true;
  bool isVoltar = true;

  List<ServicosModel> servicosModel = [];
  List<ServicosModel> sugestoes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscarServicos();
    });
  }

  @override
  void dispose() {
    servicoController.dispose();
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isPesquisa == true ? 'Serviços oferecidos' : 'Incluir serviço',
        ),
        leading: IconButton(
          onPressed: () {
            if (isPesquisa) {
              Navigator.pop(context);
            } else {
              setState(() {
                isPesquisa = true;
              });
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<ServicosController, ServicosState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              hideLoader();
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
            },
            success: () {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return isPesquisa == true
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        height: 60,
                        margin: EdgeInsets.only(top: 25),
                        child: TextField(
                          autofocus: true,
                          cursorColor: ColorsConstants.appBarColor,
                          cursorHeight: 15,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              size: 25,
                              color: ColorsConstants.appBarColor,
                            ),
                          ),
                          onChanged: (value) {
                            buscarServicoPorNome(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 450,
                        width: 900,
                        child: ListView.builder(
                          itemCount: state.servicos != null
                              ?
                                // state.dentistas!.length
                                (sugestoes.isNotEmpty
                                    ? sugestoes.length
                                    : state.servicos!.length)
                              : 0,
                          itemBuilder: (context, index) {
                            ServicosModel servicos = sugestoes.isNotEmpty
                                ? sugestoes[index]
                                : state.servicos![index];
                            final valor = sugestoes.isNotEmpty
                                ? sugestoes[index].vl
                                : state.servicos![index].vl;
                            return TableServicos(
                              title:
                                  servicos.nome ?? sugestoes[index].nome ?? "",
                              valor: formataVl(valor.toString()),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        width: 900,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isPesquisa = false;
                            });
                            valorController.clear();
                            servicoController.clear();
                          },
                          child: Text(
                            'Registrar novo serviço',
                            style: context.cusotomFontes.textItalic.copyWith(
                              color: ColorsConstants.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Serviço",
                              hintText: "Descrição do serviço oferecido",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("Obrigatorio"),
                            ]),
                            controller: servicoController,
                            focusNode: servicoFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            onFieldSubmitted: (value) {
                              valorFocus.requestFocus();
                              setState(() {
                                // isVoltar = !isVoltar;
                                isVoltar = isPesquisa;
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 400,
                          height: 60,
                          child: TextFormField(
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              labelText: "Valor",
                              hintText: "Informe o valor do serviço",
                            ),
                            controller: valorController,
                            focusNode: valorFocus,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [moedaFormatter],
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 15),
                          alignment: Alignment.center,
                          width: 900,
                          child: ElevatedButton(
                            onPressed: () async {
                              // if (isVoltar) {
                              
                              //   setState(() {
                              //     isPesquisa = !isPesquisa;
                              //   });
                              // } else {
                                
                              // }

                              // servicosModel = await controller.buscarServicos();
                              await registrarServicos();
                                // setState(() {
                                //   isPesquisa = !isPesquisa;
                                // });
                                refresh();
                            },
                            child: Text(
                              'Salvar dados',
                              style: context.cusotomFontes.textItalic.copyWith(
                                color: ColorsConstants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  //! Formatter para o TextFormField
  final moedaFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
    // Remove tudo que não é número
    String onlyNumbers = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (onlyNumbers.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Converte para valor decimal
    double value = double.parse(onlyNumbers) / 100;

    // Formata com separador de milhar e vírgula decimal
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '', // sem R$ no formatter, opcional
      decimalDigits: 2,
    );

    String newText = formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  });

  //! registrar servico
  Future<void> registrarServicos() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      String texto = valorController.text
          .replaceAll(
            RegExp(r'[^0-9,\.]'),
            '',
          ) // remove tudo que não é número, vírgula ou ponto
          .replaceAll('.', '')
          .replaceAll(',', '.');
      num? vl = num.tryParse(texto);
      ServicosModel model = ServicosModel(nome: servicoController.text, vl: vl);

      await controller.registrarServicos(model);
    }
  }

  //! formata vl
  String formataVl(String value) {
    String texto = value.replaceAll('.', ',');
    return texto;
  }

  //! buscar serviços por nome
  void buscarServicoPorNome(String value) {
    String nome = value;
    setState(() {
      sugestoes = controller.state.servicos!
          .where((p) => p.nome!.toLowerCase().contains(nome.toLowerCase()))
          .toList();
    });
  }

  void refresh() async {
    await controller.buscarServicos(); // recarrega a lista do backend
    setState(() {
      isPesquisa = true;
      isVoltar = isPesquisa;
    }); // força a tela a rebuildar com os novos dados
  }
}
