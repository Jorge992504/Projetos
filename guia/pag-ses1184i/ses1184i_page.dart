import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsmobile/app/core/ui/base_state/base_state.dart';
import 'package:hsmobile/app/core/ui/helpers/size_extensions.dart';
import 'package:hsmobile/app/core/ui/styles/app_colors.dart';
import 'package:hsmobile/app/core/ui/styles/text_styles.dart';
import 'package:hsmobile/app/core/ui/widgets/custom_button.dart';
import 'package:hsmobile/app/core/ui/widgets/custom_text_form_field.dart';
import 'package:hsmobile/app/pages/barcode/barcode_scanner_simple.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_controller.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_state.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_validator.dart';

class Ses1184iPage extends StatefulWidget {
  const Ses1184iPage({super.key});

  @override
  State<Ses1184iPage> createState() => _Ses1184iPageState();
}

class _Ses1184iPageState extends BaseState<Ses1184iPage, Ses1184iController> {
  late Ses1184iValidator ses1184iValidator;
  @override
  void initState() {
    super.initState();
    ses1184iValidator = Ses1184iValidator(ses1184iController: controller);
  }

  @override
  void dispose() {
    ses1184iValidator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Ses1184iController, Ses1184iState>(
      listener: (context, state) {
        state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          loaded: hideLoader,
          failure: () {
            showError(state.errorMessage ?? "Erro não informado!");
            hideLoader();
          },
          success: () {
            showSuccess('Troca realizada com sucesso');
            hideLoader();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            iconTheme: IconThemeData(color: AppColors.instance.tela),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lançamento de trocas",
                overflow: TextOverflow.visible,
                style: context.textStyles.textBold.copyWith(
                  color: AppColors.instance.tela,
                  fontSize: 16,
                  height: 1,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.2),
                      margin: EdgeInsets.only(top: 15, left: 10),
                      maxLength: 4,
                      textAlign: TextAlign.right,
                      labelText: 'Filial',
                      controller: ses1184iValidator.text_controller_cdFilial,
                      focusNode: ses1184iValidator.cdFilialFocus,
                      focusNodeNext: ses1184iValidator.cdBarraFocus,
                      onFieldSubmitted: (value) async {
                        final result = await ses1184iValidator.validarFilial();
                        if (result != null && result != ' ') {
                          showWarn(result);
                        }
                      },
                    ),
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.7),
                      margin: EdgeInsets.only(top: 15, left: 15),
                      labelText: 'Nome',
                      enabled: false,
                      controller: ses1184iValidator.text_controller_nmFilial,
                    ),
                  ],
                ),
                CustomTextFormField(
                  height: 40,
                  width: context.percentWidth(0.93),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  maxLength: 14,
                  textAlign: TextAlign.right,
                  labelText: 'Código produto/barra',
                  controller: ses1184iValidator.text_controller_cdBarra,
                  focusNode: ses1184iValidator.cdBarraFocus,
                  focusNodeNext: ses1184iValidator.cdMotivoFocus,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      bool succes = await _openCamera();
                      if (succes) {
                        ses1184iValidator.validarProdutoBarra();
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      size: 20,
                    ),
                  ),
                  onFieldSubmitted: (value) async {
                    final result =
                        await ses1184iValidator.validarProdutoBarra();
                    if (result != null && result != ' ') {
                      showWarn(result);
                    }
                  },
                ),
                CustomTextFormField(
                  height: 40,
                  width: context.percentWidth(0.93),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  textAlign: TextAlign.right,
                  labelText: 'Produto',
                  controller: ses1184iValidator.text_controller_produto,
                  enabled: false,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.2),
                      margin: EdgeInsets.only(top: 10, left: 10),
                      maxLength: 2,
                      textAlign: TextAlign.right,
                      labelText: 'Motivo',
                      controller: ses1184iValidator.text_controller_cdMotivo,
                      focusNode: ses1184iValidator.cdMotivoFocus,
                      onFieldSubmitted: (value) async {
                        final result = await ses1184iValidator.validarMotivo();
                        if (result != null && result != ' ') {
                          showWarn(result);
                        }
                      },
                    ),
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.7),
                      margin: EdgeInsets.only(top: 10, left: 15),
                      labelText: 'Nome',
                      enabled: false,
                      controller: ses1184iValidator.text_controller_nmMotivo,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.27),
                      margin: EdgeInsets.only(top: 10, left: 10),
                      maxLength: 7,
                      textAlign: TextAlign.right,
                      labelText: 'Fornecedor',
                      controller:
                          ses1184iValidator.text_controller_cdFornecedor,
                      focusNode: ses1184iValidator.cdFornecedorFocus,
                      focusNodeNext: ses1184iValidator.qtProdutoFocus,
                      onFieldSubmitted: (value) async {
                        final result =
                            await ses1184iValidator.validarFornecedor();
                        if (result != null && result != ' ') {
                          showWarn(result);
                        }
                      },
                    ),
                    CustomTextFormField(
                      height: 40,
                      width: context.percentWidth(0.63),
                      margin: EdgeInsets.only(top: 10, left: 15),
                      labelText: 'Nome',
                      enabled: false,
                      controller:
                          ses1184iValidator.text_controller_nmFornecedor,
                    ),
                  ],
                ),
                CustomTextFormField(
                  height: 40,
                  width: context.percentWidth(0.5),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  textAlign: TextAlign.right,
                  labelText: 'Já lançado',
                  controller: ses1184iValidator.text_controller_qtTroca,
                  enabled: false,
                ),
                CustomTextFormField(
                  height: 40,
                  width: context.percentWidth(0.5),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  textAlign: TextAlign.right,
                  labelText: 'Qt produto',
                  controller: ses1184iValidator.text_controller_qtProduto,
                  focusNode: ses1184iValidator.qtProdutoFocus,
                  focusNodeNext: ses1184iValidator.obsFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (value) async {
                    final result = await ses1184iValidator.validarQuantidade();
                    if (result != null && result != ' ') {
                      showWarn(result);
                    }
                  },
                ),
                CustomTextFormField(
                  height: 40,
                  width: context.percentWidth(0.5),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  textAlign: TextAlign.right,
                  labelText: 'Saldo',
                  controller: ses1184iValidator.text_controller_qtSaldo,
                  enabled: false,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  width: context.percentWidth(0.93),
                  child: TextFormField(
                    controller: ses1184iValidator.text_controller_obs,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Observações',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Salvar',
                  onPressed: () async {
                    ses1184iValidator.salvarFocus.requestFocus();
                    final result = await ses1184iValidator.gravarRegistro();
                    if (result == null) {
                      showSuccess('Sucesso ao gravar registro');
                    } else {
                      showWarn(result);
                    }
                  },
                  icon: Icons.check,
                  width: context.percentWidth(0.3),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 270, top: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _openCamera() async {
    var codeBar = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BarcodeScannerSimple()));
    if (codeBar != null) {
      setState(() {
        ses1184iValidator.text_controller_cdBarra.text = codeBar;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        ses1184iValidator.cdBarraFocus.requestFocus();
        ses1184iValidator.text_controller_cdBarra.selection = TextSelection(
          baseOffset: 0,
          extentOffset: ses1184iValidator.text_controller_cdBarra.text.length,
        );
      });

      return true;
    } else {
      return false;
    }
  }
}
