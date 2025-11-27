import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/convenio_model.dart';
import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';
import 'package:dente/src/models/response/listar_convenios_response.dart';
import 'package:dente/src/pages/convenio/convenio_controller.dart';
import 'package:dente/src/pages/convenio/convenio_state.dart';
import 'package:dente/src/pages/convenio/widgets/table_convenios.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class ConvenioPage extends StatefulWidget {
  const ConvenioPage({super.key});

  @override
  State<ConvenioPage> createState() => _ConvenioPageState();
}

class _ConvenioPageState extends BaseState<ConvenioPage, ConvenioController> {
  final formKey = GlobalKey<FormState>();

  final convenioController = TextEditingController();
  final valorController = TextEditingController();
  final tratamentoController = TextEditingController();

  final convenioFocus = FocusNode();
  final valorFocus = FocusNode();
  final tratamentoFocus = FocusNode();

  bool isPesquisa = true;
  bool isVoltar = true;

  List<ListarConveniosResponse> convenioModel = [];
  List<ListarConveniosResponse> sugestoes = [];
  List<BuscaServicosAgendamentoResponse>? servicosDisponiveis = [];

  int idServico = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.buscaConvenios();
      await controller.buscaServicos();
      servicosDisponiveis = controller.state.servicosModel;
    });
  }

  @override
  void dispose() {
    convenioController.dispose();
    valorController.dispose();
    tratamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isPesquisa == true ? 'Convenios' : 'Incluir convenio'),
        leading: Visibility(
          visible: isPesquisa,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: BlocConsumer<ConvenioController, ConvenioState>(
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
                            buscarConvenioPorNome(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 450,
                        width: 900,
                        child: ListView.builder(
                          itemCount: state.convenioModel != null
                              ?
                                // state.dentistas!.length
                                (sugestoes.isNotEmpty
                                    ? sugestoes.length
                                    : state.convenioModel!.length)
                              : 0,
                          itemBuilder: (context, index) {
                            ListarConveniosResponse convenio =
                                sugestoes.isNotEmpty
                                ? sugestoes[index]
                                : state.convenioModel![index];
                            final valor = sugestoes.isNotEmpty
                                ? sugestoes[index].valor_pago
                                : state.convenioModel![index].valor_pago;
                            return TableConvenios(
                              parceiro:
                                  convenio.parceiro ??
                                  sugestoes[index].parceiro ??
                                  "",
                              valor: valor.toString(),
                              tratamento: convenio.tratamento,
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
                            convenioController.clear();
                          },
                          child: Text(
                            'Registrar novo convenio',
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
                              labelText: "Parceiro",
                              hintText:
                                  "Nome da empresa que oferece o convenio",
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required("Obrigatorio"),
                            ]),
                            controller: convenioController,
                            focusNode: convenioFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            onFieldSubmitted: (value) {
                              tratamentoFocus.requestFocus();
                              setState(() {
                                // isVoltar = !isVoltar;
                                isVoltar = isPesquisa;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 410,
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField2<String>(
                            focusNode: tratamentoFocus,

                            value: tratamentoController.text.isEmpty
                                ? null
                                : tratamentoController.text,
                            decoration: InputDecoration(
                              labelText: "Serviço",
                              hintText:
                                  "Informe o serviço que cobre o convenio",
                              labelStyle: TextStyle(
                                color: ColorsConstants.appBarColor,
                              ),
                              hintStyle: TextStyle(
                                color: ColorsConstants.appBarColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorsConstants.appBarColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorsConstants.appBarColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                            isExpanded: true,
                            iconStyleData: IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: ColorsConstants.appBarColor,
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              direction: DropdownDirection
                                  .textDirection, // 👈 força abrir para baixo
                              maxHeight: 300,
                              offset: const Offset(
                                0,
                                8,
                              ), // pequeno espaçamento abaixo do campo
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorsConstants.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsConstants.appBarColor,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            items: servicosDisponiveis!.map((servico) {
                              return DropdownMenuItem<String>(
                                value: servico.nome,
                                child: Text(
                                  servico.nome ?? '',
                                  style: context.cusotomFontes.textRegular
                                      .copyWith(
                                        fontSize: 16,
                                        color: ColorsConstants.appBarColor,
                                      ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                tratamentoController.text = value ?? '';
                                servicosDisponiveis!
                                    .where(
                                      (servico) =>
                                          servico.nome == value.toString(),
                                    )
                                    .forEach((servico) {
                                      idServico = servico.id!;
                                    });
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
                              labelText:
                                  "Informe a percentagem do valor que cobre o convenio",
                              hintText: "Percentagem",
                            ),
                            controller: valorController,
                            focusNode: valorFocus,
                            textInputAction: TextInputAction.done,
                            // inputFormatters: [moedaFormatter],
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 15),
                          alignment: Alignment.center,
                          width: 900,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (isVoltar) {
                                setState(() {
                                  isPesquisa = !isPesquisa;
                                });
                              } else {
                                await registrarConvenio();
                                refresh();
                              }
                            },
                            child: Text(
                              isVoltar ? "Voltar" : 'Salvar dados',
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

  //! registrar servico
  Future<void> registrarConvenio() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      ConvenioModel model = ConvenioModel(
        parceiro: convenioController.text,
        valorPago: num.tryParse(valorController.text) ?? 0,
        tratamento: idServico,
      );

      await controller.incluirConvenios(model);
    }
  }

  //! formata vl
  String formataVl(String value) {
    String texto = value.replaceAll('.', ',');
    return texto;
  }

  //! buscar serviços por nome
  void buscarConvenioPorNome(String value) {
    String nome = value;
    setState(() {
      sugestoes = controller.state.convenioModel!
          .where((p) => p.parceiro!.toLowerCase().contains(nome.toLowerCase()))
          .toList();
    });
  }

  void refresh() async {
    await controller.buscaConvenios(); // recarrega a lista do backend
    setState(() {
      isPesquisa = true;
      isVoltar = isPesquisa;
    }); // força a tela a rebuildar com os novos dados
  }
}
